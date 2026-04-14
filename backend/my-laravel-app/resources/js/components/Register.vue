<style scoped>
@keyframes pulse-red {
  0% {
    box-shadow: 0 0 0 0 rgba(157, 2, 8, 0.2);
  }
  50% {
    box-shadow: 0 0 8px 4px rgba(228, 0, 8, 0.3);
  }
  100% {
    box-shadow: 0 0 0 0 rgba(157, 2, 8, 0.2);
  }
}

form {
    max-width: 400px;
    padding: 24px;
    margin: 40px auto;
    background-color: white;
    border: 1px solid #DADADA;
    border-radius: 5px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    align-items: center;
}

form label {
    color: #555555;
    display: block;
    margin-bottom: 5px;
    font-family: 'nunito', sans-serif;
}

form .input-group {
    margin-bottom: 15px;
}

form input {
    width: 100%;
    padding: 10px 12px;
    margin-bottom: 15px;
    border: 1px solid #DADADA;
    border-radius: 3px;
    box-sizing: border-box;
    font-family: 'nunito', sans-serif;
    font-size: 14px;
}

form input:focus {
    border-color: linear-gradient(to bottom, #9D0208, #D00000);
    animation: pulse-red 1.5s infinite;
    outline: none;
}
form #registration-title {
    text-align: center;
    margin-bottom: 20px;
    color: #222222;
    font-family: 'playfair display', serif;
    font-weight: 400;
}

form .terms {
    display: flex;
    align-items: flex-start;
    gap: 8px;
    margin-bottom: 20px;
    font-family: 'nunito', sans-serif;
    font-size: 14px;
    color: #555555;
}

form .terms input {
    width: auto;
    margin: 3px 0 0;
}

form .terms label {
    margin-bottom: 0;
}

form .registration-buttons {
    display: flex;
    gap: 10px;
    margin-bottom: 20px;
}

form button {
    flex: 1;
    padding: 10px 14px;
    border: none;
    border-radius: 3px;
    background-color: #1f6f5f;
    color: white;
    font-family: 'nunito', sans-serif;
    font-size: 14px;
    cursor: pointer;
}

form button[type="cancel"] {
    background-color: #888888;
}

form .login-link {
    text-align: center;
    font-family: 'nunito', sans-serif;
    font-size: 14px;
    color: #555555;
}

form .login-link p {
    margin: 0;
}

form .login-link a {
    color: #1f6f5f;
    text-decoration: none;
}

form .login-link a:hover {
    text-decoration: underline;
}
</style>

<template>

    <form action="registration">
        <h1 id="registration-title">Reģistrācija</h1>

        <div class="input-group">
            <label for="name">Vārds:</label>
            <input type="text" id="name" name="name" required>

            <label for="last-name">Uzvārds:</label>
            <input type="text" id="last-name" name="last-name" required>

            <label for="email">E-pasts:</label>
            <input type="email" id="email" name="email" required>

            <label for="password">Parole:</label>
            <input type="password" id="password" name="password" required>

            <label for="password_confirmation">Atkārtota parole:</label>
            <input type="password" id="password-confirmation" name="password-confirmation" required>
        </div>

        <div class="terms">
            <input type="checkbox" id="terms" name="terms" required>
            <label for="terms">Es piekrītu noteikumiem un nosacījumiem</label>
        </div>

        <div class="registration-buttons">
            <button type="submit">Reģistrēties</button>
            <button type="cancel">Atcelt</button>
        </div>

        <div class="login-link">
            <p>Jau ir konts? <a href="/login">Pieslēgties</a></p>
        </div>
    </form>

</template>

<script setup>

</script>
