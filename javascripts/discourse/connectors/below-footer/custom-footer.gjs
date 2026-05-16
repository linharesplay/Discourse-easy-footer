import CustomFooter from "../../components/custom-footer";

// Using template-only component for better performance (no component instance overhead)
<template>
  <div class="below-footer-outlet custom-footer">
    <CustomFooter @showFooter={{@outletArgs.showFooter}} />
  </div>
</template>
