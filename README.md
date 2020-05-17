# To run on personal laptop
`sudo ansible-pull --check -U https://github.com/kylerjohnston/ansible.git personal_laptop.yml`

# To run on descartes
You need to create a `.env` file in the root of the repository to populate secrets. You can use the `generate-env.rb` script to generate this file. Then, run the playbook with its context like:

`dotenv ansible-playbook -i home_inventory descartes.yml`
