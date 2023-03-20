import { computePosition, autoUpdate } from "@floating-ui/dom";
export { offset, shift as shiftImpl, arrow as arrowImpl } from "@floating-ui/dom";

export const computePositionImpl = (referenceEl, floatingEl, options) => {
  return computePosition(referenceEl, floatingEl, options);
};
export const autoUpdateImpl = (referenceEl, floatingEl, update, options) => {
  return autoUpdate(referenceEl, floatingEl, update, options);
};
