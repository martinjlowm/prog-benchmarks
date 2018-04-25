let total1 = 0;
let total2 = 0;
const totalN = 20;
const N = 1e3;

for (let j = 0; j < totalN; j++) {
  let startTime = new Date();

  let a = [];
  const b = [1,2,3,4,5,6,7,8,9,10];

  for (let i = 0; i < N; i++) {
    a = a.concat(b);
  }

  total1 = total1 + (new Date() - startTime);
  a = [];

  startTime = new Date();

  for (let i = 0; i < N; i++) {
    a.push(...b);
  }

  total2 = total2 + (new Date() - startTime);
  process.stdout.write('.');
}

console.log('');
console.log('For ' + N + ' iterations averaged over ' + totalN + ' runs, the results are as follows:');
console.log('a = a.concat(b): ' + total1 / totalN + 's');
console.log('a.push(...b): ' + total2 / totalN + 's');
