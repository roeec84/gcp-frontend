import { useEffect, useState } from 'react';
import axios from 'axios'

const App = () => {
  const [tutorials, setTutorials] = useState([])
  useEffect(() => {
    const fetchData = async () => {
      const res = await axios.get('http://34.36.10.172/api/tutorials')
      setTutorials(res.data.map(x => x.title))
    }
    fetchData()
  }, [])
  return (
    <div>
      <div>
        {tutorials.length > 0 && tutorials.map(tut => <div>{tut}</div>)}
      </div>
      <div>
        If you can see the list above it is sign that we are connected to the backend and it takes data from SQL :)
      </div>
    </div>
  );
};
export default App;