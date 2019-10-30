<template>
  <transition name="modal" appear>
    <div class="modal modal-overlay" @click.self="$emit('close')">
      <div class="modal__contents row">
        <div class="col s12">
          <div class="card blue-grey darken-1">
            <div class="card-content white-text">
              <div v-if="!running">
                <span class="card-title">
                  Result
                  <span class="right modal__contents--topic">Total : {{result.exp_sum}}exp</span>
                  <span class="right modal__contents--topic">Failure : {{result.failure_rate}}%</span>
                </span>
                <div class="divider"></div>

                <table class="centered">
                  <thead>
                    <tr>
                      <th>name</th>
                      <th>position</th>
                      <th>exp</th>
                      <th>death</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-for="(monster,index) in result.monsters" :key="index">
                      <td>{{index}}</td>
                      <td>{{monster.position.join(",")}}</td>
                      <td>{{monster.exp}}</td>
                      <td>{{monster.death}}</td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <div v-if="running">
                <span class="card-title">
                  機械計算中...
                  <div class="preloader-wrapper small active right">
                    <div class="spinner-layer spinner-yellow-only">
                      <div class="circle-clipper left">
                        <div class="circle"></div>
                      </div><div class="gap-patch">
                        <div class="circle"></div>
                      </div><div class="circle-clipper right">
                        <div class="circle"></div>
                      </div>
                    </div>
                  </div>
                </span>
              </div>

            </div>
          </div>
        </div>
      </div>
    </div>
  </transition>
</template>

<script>
export default {
  props: {
    running: {type: Boolean, required: true},
    result: {type: Object},
  },
}
</script>

<style lang='sass' scoped>
.modal {
  &.modal-overlay {
    display: flex;
    align-items: center;
    justify-content: center;
    position: fixed;
    z-index: 1000;
    top: 0;
    left: 0;
    width: 100vw;
    min-height: 100vh;
    background: rgba(0, 0, 0, 0.5);
  }

  &__contents {
    height: 50%;
    width: 50%;
    &--topic {
      font-size: 1.2rem;
      padding-right: 2em;
    }
  }

}

// オーバーレイのトランジション
.modal-enter-active, .modal-leave-active {
  transition: opacity 0.4s;

  // オーバーレイに包含されているモーダルウィンドウのトランジション
  .modal-window {
    transition: opacity 0.4s, transform 0.4s;
  }
}

// ディレイを付けるとモーダルウィンドウが消えた後にオーバーレイが消える
.modal-leave-active {
  transition: opacity 0.6s ease 0.4s;
}

.modal-enter, .modal-leave-to {
  opacity: 0;

  .modal-window {
    opacity: 0;
    transform: translateY(-20px);
  }
}

tbody {
  display: block;
  height: 200px;
  overflow-y: scroll;
}
thead, tbody tr {
  display: table;
  width: 100%;
  table-layout: fixed;
}
thead {
  width: calc(100% - 1em);
} 
table {
  width: 100%;
}

</style>