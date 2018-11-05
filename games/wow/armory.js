let names = [
  'proudmoore/Helixe', // Sinte
  'moon-guard/Kinistriaa', // healer druid
  'sargeras/Evilwayz', // havoc DH
  'wyrmrest-accord/Ihui',


  // 'kelthuzad/melaniari',
  // 'kelthuzad/areanii',
  // 'kelthuzad/pvck',
  // 'stormrage/warlockdaddy',
  // 'sargeras/vacarus',
  // 'proudmoore/monics',// warrior
  // 'rivendare/cameron',// (rogue, warrior) early KSM
  // 'proudmoore/meowskey'
];

names = process.argv
names.shift();
names.shift();
console.log(names);

names.forEach((n) => {
  console.log(`https://worldofwarcraft.com/en-us/character/${n}`)
  console.log(`https://worldofwarcraft.com/en-us/character/${n}/achievements/dungeons-raids`)
  console.log(`https://worldofwarcraft.com/en-us/character/${n}/achievements/legacy/dungeons`)
  console.log(`https://raider.io/characters/us/${n}`)
})
