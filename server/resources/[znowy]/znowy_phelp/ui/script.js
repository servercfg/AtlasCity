const ZnowY = new Vue({
    el: "#ZnowY",

    data: {
        // Shared
        ResourceName: "znowy_phelp",
        showUI: false,

    },

    methods: {

        // START OF MAIN MENU
        OpenUIMenu() {
            this.showUI     = true;
        },

        CloseMenu() {
            axios.post(`http://${this.ResourceName}/CloseMenu`, {}).then((response) => {
                this.showUI        = false;
            }).catch((error) => { });
        },

        Choose1() {
            axios.post(`http://${this.ResourceName}/Choose1`, {}).then((response) => {
                this.showUI        = false;
            }).catch((error) => { });
        },

        Choose2() {
            axios.post(`http://${this.ResourceName}/Choose2`, {}).then((response) => {
                this.showUI        = false;
            }).catch((error) => { });
        },

        Choose3() {
            axios.post(`http://${this.ResourceName}/Choose3`, {}).then((response) => {
                this.showUI        = false;
            }).catch((error) => { });
        },

        Choose4() {
            axios.post(`http://${this.ResourceName}/Choose4`, {}).then((response) => {
                this.showUI        = false;
            }).catch((error) => { });
        },

        Choose5() {
            axios.post(`http://${this.ResourceName}/Choose5`, {}).then((response) => {
                this.showUI        = false;
            }).catch((error) => { });
        },

        Choose6() {
            axios.post(`http://${this.ResourceName}/Choose6`, {}).then((response) => {
                this.showUI        = false;
            }).catch((error) => { });
        },

        Choose7() {
            axios.post(`http://${this.ResourceName}/Choose7`, {}).then((response) => {
                this.showUI        = false;
            }).catch((error) => { });
        },

        Choose8() {
            axios.post(`http://${this.ResourceName}/Choose8`, {}).then((response) => {
                this.showUI        = false;
            }).catch((error) => { });
        },

        Choose9() {
            axios.post(`http://${this.ResourceName}/Choose9`, {}).then((response) => {
                this.showUI        = false;
            }).catch((error) => { });
        },
    },
});

// Listener from Lua CL
document.onreadystatechange = () => {
    if (document.readyState == "complete") {
        window.addEventListener("message", (event) => {
            if (event.data.type == "openUIMenu") {
                ZnowY.OpenUIMenu();
            }
        });
    }
}
