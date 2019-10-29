<template>
  <div class="row blue-grey-text text-darken-3" style="margin-bottom: 0;">
    <nav class="grey lighten-4">
      <div class="nav-wrapper">
        <div class="col s12 m10 offset-m1">
          <span class="brand-logo blue-grey-text lighten-3 setting-style">Home</span>
        </div>
      </div>
    </nav>
    <div class="col s8 offset-s2 content-main">
      <div class="row">
        <h3 class="grey-text lighten-3 center content-main__title">
          Welcome to Sumo Generator!!
        </h3>
        <p class="content-main__description">
          Sumo Generator simulates small ghoul combos in the epic video game
          <a href="https://en.wikipedia.org/wiki/Dragon_Quest_Characters:_Torneko_no_Daib%C5%8Dken_3">
            Torneko no Daibōken 3
          </a>
          .
          If you have a little anxietyies with your combo in each floor, you can test it using
          your own party settings. Sumo Generator would tell you that it may be safe or unsafe.
        </p>
      </div>
      <div class='row'>
        <div class='col l6 s12 center'>
          <router-link to="/calculate">
            <div class='btn'>
              quick try
            </div>
          </router-link>
        </div>
        <div class='col l6 s12 center'>
          <router-link to="/how_to">
            <div class='btn'>
              how to use
            </div>
          </router-link>
        </div>
      </div>
      <div class='row'>
        <h3 class="grey-text lighten-3 center">
          I hope no more tragedies . . .
        </h3>
        <div class='col l4 s10'>
          <h5>
            Inexperienced
          </h5>
          <p>
            Techniques of small ghoul combos are based on player's experiences.
            So if you are a bigginer in this technique, you would waste a lot of time
            because of lack of experiences. You can try some sample combos with Sumo Generator.
          </p>
        </div>
        <div class='col l4 s10'>
          <h5>
            Safe Settings?
          </h5>
          <p>
            Positions and action orders of your monsters are critical parameter in a combo.
            A wrong setting quickly destroys your combo, and brings you a deep grief.
            Sumo Generator simulates a combo with whatever a setting you want to try.
          </p>
        </div>
        <div class='col l4 s10'>
          <h5>
            Overwork Death
          </h5>
          <p>
            Even you are a experienced player, it is difficult to estimate the
            natural health healing for each monster. 
            We don't want to moune for killer machines which are killed unexpectedly.
            Sumo Generator reproducts those complex behaviors. If you want to check the 
            source code in the simulation, please check
            <a href="https://github.com/shimoch-214/sumo-generator">
              my github repository
            </a>
            .
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  
}
</script>

<style>

</style>