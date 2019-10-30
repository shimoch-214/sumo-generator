<template>
  <p>
    {{showMonster}}
  </p>
</template>

<script>
export default {
  props: {
    row: { type: Number, required: true },
    col: { type: Number, required: true },
    monsterForms: { type: Array, required: true }
  },
  computed: {
    showMonster: function() {
      var row = this.row
      var col = this.col
      var name = ""
      this.monsterForms.forEach(function(monster, index) {
        if (monster.position==`${row},${col}`) {
          var order = monster.order+1
          if (monster.tribe=="km") {
            name = "機"+order
          } else if (monster.tribe=="su") {
            name = "ス"+order
          } else if (monster.tribe=="ho") {
            name = "ホ"+order
          } else if (monster.tribe="seed") {
            name = "種"
          }
        }
      })
      return name
    }
  }
}
</script>

<style>

</style>