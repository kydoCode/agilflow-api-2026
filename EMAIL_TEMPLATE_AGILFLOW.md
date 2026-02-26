# Template Email AgilFlow - Reset Password

## HTML Template Complet

```html
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Réinitialisation de mot de passe - AgilFlow</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
        
        body {
            margin: 0;
            padding: 0;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, #0F172A 0%, #1E293B 100%);
            color: #1E293B;
            min-height: 100vh;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 40px 20px;
        }
        .card {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 48px;
            box-shadow: 0 20px 40px rgba(15, 23, 42, 0.3);
            border: 1px solid rgba(148, 163, 184, 0.2);
        }
        .header {
            text-align: center;
            margin-bottom: 40px;
        }
        .logo {
            margin-bottom: 32px;
        }
        .logo-text {
            font-size: 36px;
            font-weight: 700;
            color: #1E293B;
            letter-spacing: -0.02em;
        }
        h1 {
            color: #1E293B;
            font-size: 24px;
            font-weight: 600;
            margin: 0 0 8px 0;
            letter-spacing: -0.01em;
        }
        .subtitle {
            color: #64748B;
            font-size: 16px;
            margin: 0 0 40px 0;
            font-weight: 400;
        }
        .content {
            line-height: 1.6;
            margin-bottom: 32px;
            color: #475569;
            font-size: 16px;
        }
        .button {
            display: inline-block;
            background: #1E293B;
            color: white;
            text-decoration: none;
            padding: 16px 32px;
            border-radius: 12px;
            font-weight: 500;
            font-size: 16px;
            text-align: center;
            transition: all 0.2s ease;
        }
        .button:hover {
            background: #334155;
            transform: translateY(-1px);
        }
        .warning {
            background: #FEF2F2;
            border: 1px solid #FECACA;
            border-radius: 12px;
            padding: 16px;
            margin: 24px 0;
            color: #991B1B;
            font-size: 14px;
        }
        .footer {
            text-align: center;
            margin-top: 40px;
            padding-top: 24px;
            border-top: 1px solid #E2E8F0;
            color: #64748B;
            font-size: 13px;
            line-height: 1.5;
        }
        .footer a {
            color: #1E293B;
            text-decoration: none;
        }
        .legal {
            margin-top: 24px;
            font-size: 12px;
            color: #94A3B8;
        }
        @media (max-width: 600px) {
            .container { padding: 20px 15px; }
            .card { padding: 32px 24px; }
            .logo-text { font-size: 32px; }
            h1 { font-size: 22px; }
            .button { padding: 14px 28px; }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="header">
                <div class="logo">
                    <div class="logo-text">AgilFlow</div>
                </div>
                <h1>Réinitialisation de mot de passe</h1>
                <p class="subtitle">Sécurisez votre espace de travail</p>
            </div>
            
            <div class="content">
                <p>Bonjour,</p>
                <p>Vous avez demandé la réinitialisation de votre mot de passe pour votre compte AgilFlow.</p>
                <p>Cliquez sur le bouton ci-dessous pour définir un nouveau mot de passe :</p>
            </div>
            
            <div style="text-align: center; margin: 32px 0;">
                <a href="{{RESET_URL}}" class="button">
                    Réinitialiser mon mot de passe
                </a>
            </div>
            
            <div class="warning">
                <strong>Important :</strong> Ce lien expire dans 1 heure pour votre sécurité. Si vous n'êtes pas à l'origine de cette demande, ignorez cet email.
            </div>
            
            <div class="content">
                <p><strong>Lien alternatif :</strong></p>
                <p style="word-break: break-all; color: #64748B; font-size: 14px; background: #F8FAFC; padding: 12px; border-radius: 8px;">{{RESET_URL}}</p>
            </div>
            
            <div class="footer">
                <p>Email envoyé par AgilFlow</p>
                <p>Plateforme de gestion agile</p>
                <p><a href="https://agilflow.app">agilflow.app</a></p>
                
                <div class="legal">
                    <p>Cet email concerne la sécurité de votre compte et ne peut pas faire l'objet d'un désabonnement.</p>
                    <p>AgilFlow - Mentions légales disponibles sur notre site web.</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
```

## Version Simplifiée (pour Resend)

```html
<div style="max-width: 600px; margin: 0 auto; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;">
    <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 40px 20px;">
        <div style="background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(10px); border-radius: 20px; padding: 40px; box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);">
            
            <!-- Header -->
            <div style="text-align: center; margin-bottom: 30px;">
                <div style="display: inline-flex; align-items: center; gap: 12px; margin-bottom: 20px;">
                    <div style="width: 48px; height: 48px; background: linear-gradient(135deg, #1D4ED8, #3B82F6); border-radius: 12px; display: flex; align-items: center; justify-content: center; color: white; font-weight: bold; font-size: 20px;">A</div>
                    <div style="font-size: 28px; font-weight: bold; color: #1D4ED8;">AgilFlow</div>
                </div>
                <h1 style="color: #1F2937; font-size: 24px; margin: 0 0 10px 0;">Réinitialisation de mot de passe</h1>
                <p style="color: #6B7280; font-size: 16px; margin: 0 0 30px 0;">Sécurisez votre compte en quelques clics</p>
            </div>
            
            <!-- Content -->
            <div style="line-height: 1.6; margin-bottom: 30px;">
                <p>Bonjour,</p>
                <p>Vous avez demandé la réinitialisation de votre mot de passe pour votre compte AgilFlow.</p>
                <p>Cliquez sur le bouton ci-dessous pour créer un nouveau mot de passe sécurisé :</p>
            </div>
            
            <!-- Button -->
            <div style="text-align: center; margin: 30px 0;">
                <a href="{{RESET_URL}}" style="display: inline-block; background: linear-gradient(135deg, #1D4ED8, #3B82F6); color: white; text-decoration: none; padding: 16px 32px; border-radius: 12px; font-weight: 600; font-size: 16px; box-shadow: 0 4px 12px rgba(29, 78, 216, 0.3);">
                    🔐 Réinitialiser mon mot de passe
                </a>
            </div>
            
            <!-- Warning -->
            <div style="background: rgba(239, 68, 68, 0.1); border: 1px solid rgba(239, 68, 68, 0.2); border-radius: 8px; padding: 16px; margin: 20px 0; color: #DC2626; font-size: 14px;">
                <strong>⚠️ Important :</strong> Ce lien expire dans <strong>1 heure</strong> pour votre sécurité.
            </div>
            
            <!-- Footer -->
            <div style="text-align: center; margin-top: 40px; padding-top: 20px; border-top: 1px solid rgba(0, 0, 0, 0.1); color: #6B7280; font-size: 14px;">
                <p>Cet email a été envoyé par <strong>AgilFlow</strong></p>
                <p><a href="https://agilflow.app" style="color: #1D4ED8; text-decoration: none;">agilflow.app</a></p>
            </div>
            
        </div>
    </div>
</div>
```

## Variables à remplacer

- `{{RESET_URL}}` → URL complète avec token
- Couleurs cohérentes avec la DA AgilFlow
- Design glassmorphique responsive
- Sécurité et urgence mises en avant

## Intégration dans le controller

```javascript
const resetUrl = `${process.env.FRONTEND_URL || 'http://localhost:5173'}/reset-password/${token}`;
const htmlTemplate = `[Version Simplifiée ci-dessus]`.replace(/{{RESET_URL}}/g, resetUrl);
```