/*
 * Desktop-only access check for Feral
 */

export function checkDesktopAccess(): boolean {
    // Check if running in Electron
    if (window.electron) {
        return true;
    }

    // Additional check via user agent
    const userAgent = navigator.userAgent.toLowerCase();
    if (userAgent.includes('electron')) {
        return true;
    }

    return false;
}

export function enforceDesktopOnly(): void {
    if (!checkDesktopAccess()) {
        // Clear the page and show error message
        document.body.innerHTML = `
            <div style="display: flex; justify-content: center; align-items: center; height: 100vh; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; font-family: sans-serif;">
                <div style="text-align: center; padding: 2rem;">
                    <h1 style="font-size: 3rem; margin-bottom: 1rem;">Accès Web Désactivé</h1>
                    <p style="font-size: 1.2rem; margin-bottom: 2rem;">Feral n'est accessible que via l'application de bureau.</p>
                    <a href="https://feralisme.fr/download" style="display: inline-block; padding: 1rem 2rem; background: white; color: #667eea; text-decoration: none; border-radius: 0.5rem; font-weight: bold;">
                        Télécharger Feral Desktop
                    </a>
                </div>
            </div>
        `;
        
        // Stop all further execution
        throw new Error('Desktop-only access enforced');
    }
}