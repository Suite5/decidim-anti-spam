// Function to open the selected tab
function openTab(event, contentId) {
  // Hide all contents
  const contents = document.getElementsByClassName('content');
  for (let i = 0; i < contents.length; i++) {
    contents[i].classList.remove('active');
  }

  // Remove the 'active' class from all tabs
  const tabs = document.getElementsByClassName('tab');
  for (let i = 0; i < tabs.length; i++) {
    tabs[i].classList.remove('active');
  }

  // Display the content of the clicked tab and mark the tab as active
  document.getElementById(contentId).classList.add('active');
  event.currentTarget.classList.add('active');
}

// Add event listeners to tabs after the DOM has loaded
document.addEventListener('DOMContentLoaded', () => {
  const tabs = document.getElementsByClassName('tab');
  for (let i = 0; i < tabs.length; i++) {
    tabs[i].addEventListener('click', function(event) {
      openTab(event, this.getAttribute('data-content-id'));
    });
  }
});
