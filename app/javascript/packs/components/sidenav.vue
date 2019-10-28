<template>
  <ul class="sidenav sidenav-fixed blue-grey darken-3" id="slide-out" style="transform: translateX(0%);">
    <li>
      <div class="logo-wrapper">
        <a class="brand-logo" href="#">
          <div class="backgroud title-logo">
            <router-link to="/">
              Sumo Generator
            </router-link>
          </div>
        </a>
      </div>
    </li>
    <li>
      <div class="divider"></div>
    </li>
    <li>
      <router-link to="/">
        Home
      </router-link>
    </li>
    <li>
      <router-link to="/how_to">
        How to use
      </router-link>
    </li>
    <li>
      <router-link to="/calculate">
        Calculate
      </router-link>
    </li>
    <li>
      <ul class="collapsible collapsible-accordion">
        <li>
          <a class="collapsible-header waves-effect waves-light">
            <span style="padding: 16px;">Sample Settings</span>
            <i class="material-icons chevron right white-text">chevron_left</i>
          </a>
          <div class="collapsible-body blue-grey darken-3">
            <ul>
              <li>
                <a href="#">
                  <span style="padding: 16px;">3 on 3</span>
                </a>
              </li>
              <li>
                <a href="#">
                  <span style="padding: 16px;">3 on 3 double</span>
                </a>
              </li>
              <li>
                <a href="#">
                  <span style="padding: 16px;">5 on 5 double</span>
                </a>
              </li>
            </ul>
          </div>
        </li>
      </ul>
    </li>
  </ul>
</template>

<script>

// script for mount materialize
document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('.sidenav');
    var instances = M.Sidenav.init(elems, {});
    var collapsibleElem = document.querySelector('.collapsible');
    var collapsibleInstance = M.Collapsible.init(collapsibleElem, { accordion: true});
});

export default {

}

</script>

<style>
.title-logo {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 200px;
  font-size: 28px;
  letter-spacing: 0.1em;
  font-family: Arial;
}
</style>