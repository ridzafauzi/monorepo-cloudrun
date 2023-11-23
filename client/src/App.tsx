import { User, greetUser } from "@monorepo/shared"

function App() {
	const user: User = {
		firstName: "Client",
		lastName: "User",
		email: "clientuser@test.com",
		isAdmin: false
	};

	const onGreetClicked = () => {
		greetUser(user);
	}

	return (
		<div className="App">
			<h1>Client App</h1>
			<button onClick={onGreetClicked}>Greet Client!</button>
		</div>
	);
}

export default App;
