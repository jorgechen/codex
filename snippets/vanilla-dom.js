// checkbox
// NOTE: SPAs (React, Angular) may not recognize that the checkbox changed, so we must also dispatchEvent(new MouseEvent)
$('input[lorem-ipsum="dolor"][value="Yes"]')[0].checked = true

// click
// https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/MouseEvent
$('input[lorem="ipsum"][value="Yes"]')[0].dispatchEvent(new MouseEvent('click', {
  view: window,
  bubbles: true,
  cancelable: true,
}))


// click
// using XPath
const requestBuildResults = document.evaluate(
  '//a[text()="Lorem"]',
  document,
  null,
  XPathResult.ORDERED_NODE_SNAPSHOT_TYPE,
  null,
)
requestBuildResults.snapshotItem(0).dispatchEvent((new MouseEvent('click', {
    view: window,
    bubbles: true,
    cancelable: true,
  })),
)
