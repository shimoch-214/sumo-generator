class SampleSetting < ActiveHash::Base
  self.data=[
    { id: 1, setting: {
      field: [
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0],
        [0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0],
        [0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      ],
      monsterForms: [
        {id: 1, tribe: "km", order: 0, lv: "13", position: "3,6", weaken: "6", join: true, doping: "0", sealed: false, speed: false, strip: false, friend: true},
        {id: 2, tribe: "km", order: 1, lv: "13", position: "2,6", weaken: "6", join: true, doping: "0", sealed: false, speed: false, strip: false, friend: true},
        {id: 3, tribe: "km", order: 2, lv: "13", position: "1,6", weaken: "6", join: true, doping: "0", sealed: false, speed: false, strip: false, friend: true},
        {id: 4, tribe: "km", order: 3, lv: "13", position: "3,3", weaken: "0", join: true, doping: "0", sealed: false, speed: false, strip: false, friend: true},
        {id: 5, tribe: "km", order: 4, lv: "13", position: "2,3", weaken: "0", join: true, doping: "0", sealed: false, speed: false, strip: false, friend: true},
        {id: 6, tribe: "km", order: 5, lv: "13", position: "1,3", weaken: "0", join: true, doping: "0", sealed: false, speed: false, strip: false, friend: true},
        {id: 7, tribe: "ho", order: 6, lv: "20", position: "4,6", weaken: "0", join: true, doping: "0", sealed: false, speed: false, strip: false, friend: true},
        {id: 8, tribe: "ho", order: 7, lv: "20", position: "2,7", weaken: "0", join: true, doping: "0", sealed: false, speed: false, strip: false, friend: true},
        {id: 9, tribe: "km", order: 8, lv: "", position: "", weaken: "0", join: false, doping: "0", sealed: false, speed: false, strip: false, friend: true},
        {id: 10, tribe: "km", order: 9, lv: "", position: "", weaken: "0", join: false, doping: "0", sealed: false, speed: false, strip: false, friend: true},
        {id: 11, tribe: "seed", order: 0, lv: "1", position: "3,5", weaken: "0", join: true, doping: "0", sealed: false, speed: false, strip: false, friend: false}
      ],
      turns: 1000,
      times: 10,
    }}
  ]
end
