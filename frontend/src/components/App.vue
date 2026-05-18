<style>
    @import "tailwindcss";

    .desktop-icon {
    @apply flex flex-col items-center justify-center w-24 h-24 mt-5 cursor-pointer;
    }

    body {
        margin: 0;
        padding: 0;
    }

    @layer utilities {
        .icon-drop-shadow {
            filter: drop-shadow(2px 2px 2px black);
        }

        .text-shadow {
            text-shadow: 2px 2px 2px black;
            color: white;
        }

        .pixelify-font-header {
            font-family: 'Pixelify Sans', sans-serif;
            font-weight: 700;
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
