import Sequelize = require('sequelize');
import definePost, {PostAttributes} from './models/post';
import defineComment from './models/comment';
import defineAuthor from './models/author';
import defineCategory from './models/category';
import definePostCategory from './models/post_category';
import defineRelations from './relations';
import {FindOptions} from 'sequelize';

const username = process.env.PGUSER;
const database = process.env.PGDATABASE;
const password = process.env.PGPASSWORD;
const host = process.env.PGHOST;
const port = process.env.PGPORT;

const db = new Sequelize(database, username, password, {
	host: host,
	port: port ? Number(port) : 5432,
	dialect: 'postgres',
	operatorsAliases: false
});

const options = {
	timestamps: false,
	schema: 'generator'
};

const PostModel = definePost(db, options);
const AuthorModel = defineAuthor(db, options);
defineComment(db, options);
defineCategory(db, options);
definePostCategory(db, options);

defineRelations(db);

const queryOptions: FindOptions<PostAttributes> = {
	include: [
		{ model: AuthorModel, as: 'author', required: true },
	],
	order: [ 'id' ],
	logging: false
};

PostModel.findAll(queryOptions)
	.then(async (posts) => {
		console.log(`found ${posts.length} posts`);
		for (const post of posts) {
			const categories = await post.getCategories({
				order: [ 'name' ],
				logging: false
			});
			console.log(`id: ${post.id}
  title: ${post.title}
  author: ${post.author.name} (id=${post.author.id})
  categories: ${categories.map(c => c.name).join(', ')}
  content: ${post.content}
  createdAt: ${post.createdAt}
  publishedAt: ${post.publishedAt}
  `);
		}

		process.exit();
	})
	.catch((err) => {
		console.error(err);
		process.exit(1);
	});
