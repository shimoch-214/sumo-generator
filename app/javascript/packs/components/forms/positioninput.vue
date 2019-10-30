<template>
  <input 
    type="text"
    placeholder="m,n"
    :name="name"
    :value="value"
    @change="changeValue"
  >
</template>

<script>
export default {
  name: "PositionInput",
  props: {
    name: { type: String, required: true },
    value: { type: String, required: true },
    friend: { type: Boolean, required: true },
    field: {type: Array, required: true},
    monsterForms: {type: Array, required: true},
  },
  model: {
    event: 'change'
  },
  methods: {
    changeValue: function(e) {
      if (e.target.value == "") {
        this.$emit("change", e.target.value)
        return
      }

      if (!e.target.value.match(/^\d+,\d+$/)) {
        alert("m, nの形式で入力してください")
        e.target.value = "";
        this.$emit("change", e.target.value)
        return
      }

      var position = e.target.value.split(',')
      if (Number(position[0]) < 0 || Number(position[0]) > 11 || Number(position[1]) < 0 || Number(position[1]) > 11) {
        alert("範囲外です");
        e.target.value = "";
        this.$emit("change", e.target.value)
        return
      }

      if (this.field[Number(position[0])][Number(position[1])] == 0) {
        alert("壁の中には配置できません");
        e.target.value = "";
        this.$emit("change", e.target.value)
        return
      }

      for(var i=0; i < this.monsterForms.length; i++) {
        if (e.target.value == this.monsterForms[i].position) {
          alert("他のユニットがいます");
          e.target.value = "";
          this.$emit("change", e.target.value)
          return
        }
      }
      this.$emit("change", e.target.value)
      return
    },
  },
}
</script>

<style>
</style>