import { User, greetUser } from "@monorepo/shared"

function App() {
	const user: User = {
		firstName: "Admin",
		lastName: "User",
		email: "adminuser@test.com",
		isAdmin: true
	};

	const onGreetClicked = () => {
		greetUser(user);
	}

	return (
		<div className="App">
			<h1>Admin App</h1>
			<button onClick={onGreetClicked}>Greet Admin!</button>
		</div>
	);
}


export default App
