function ytb-deploy
    if test "$argv[1]" = "--help"
        echo "Usage: ytb deploy"
        echo "Triggers the GitHub Actions workflow 'deploy-heroku.yml' (from main)"
        echo "Uses the current local branch as the ref."
        return 0
    end

    set branch (git rev-parse --abbrev-ref HEAD)
    gh workflow run deploy-heroku.yml --ref main --field environment=ytb-web-app-edgerob --field ref=$branch
end
