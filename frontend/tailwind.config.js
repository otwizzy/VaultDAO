/** @type {import('tailwindcss').Config} */
export default {
    content: [
      "./index.html",
      "./src/**/*.{js,ts,jsx,tsx}",
    ],
    theme: {
      extend: {
        colors: {
            // Custom colors for VaultDAO
            primary: "#1e1e24",
            secondary: "#2a2a35", 
            accent: "#4f46e5",
        }
      },
    },
    plugins: [],
  }
