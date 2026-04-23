<style>
    @import "tailwindcss";

    body {
        margin: 0;
        padding: 0;
    }

    .font-roboto {
        font-family: 'Roboto', sans-serif;
    }

    .win-window {
        background-color: #c0c0c0;
        border: 2px solid;
        border-top-color: white;
        border-left-color: white;
        border-right-color: #404040;
        border-bottom-color: #404040;
    }

.win-titlebar {
    background-color: #000080;
    color: white;
    padding: 4px 8px;
    font-size: 14px;
    font-weight: bold;
}

.win-body {
    padding: 12px;
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.win-input {
    background-color: white;
    padding: 4px 6px;
    font-size: 14px;
    border: 2px solid;
    border-top-color: #404040;
    border-left-color: #404040;
    border-right-color: white;
    border-bottom-color: white;
    outline: none;
}

.win-btn {
    background-color: #c0c0c0;
    padding: 4px 10px;
    font-size: 14px;
    border: 2px solid;
    border-top-color: white;
    border-left-color: white;
    border-right-color: #404040;
    border-bottom-color: #404040;
}

.win-btn:active {
    border-top-color: #404040;
    border-left-color: #404040;
    border-right-color: white;
    border-bottom-color: white;
}

</style>

<template>

    <div>
        <router-view></router-view>
    </div>

</template>

<script>
    export default {}
</script>
