// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// This test is ripped from package:crypto to test the sha1 functionality copied
// into the compiler.

library sha1_test;
import 'package:compiler/src/hash/sha1.dart';

import "package:unittest/unittest.dart";

part 'sha1_long_test_vectors.dart';
part 'sha1_short_test_vectors.dart';


void main() {
  test('expected values', _testExpectedValues);
  test('invalid use', _testInvalidUse);
  test('repeated digest', _testRepeatedDigest);
  test('long inputs', () {
    _testStandardVectors(sha1_long_inputs, sha1_long_mds);
  });
  test('short inputs', () {
    _testStandardVectors(sha1_short_inputs, sha1_short_mds);
  });
}

void _testExpectedValues() {
  var expectedValues = const [
    "da39a3ee5e6b4b0d3255bfef95601890afd80709",
    "5ba93c9db0cff93f52b521d7420e43f6eda2784f",
    "3f29546453678b855931c174a97d6c0894b8f546",
    "0c7a623fd2bbc05b06423be359e4021d36e721ad",
    "a02a05b025b928c039cf1ae7e8ee04e7c190c0db",
    "1cf251472d59f8fadeb3ab258e90999d8491be19",
    "868460d98d09d8bbb93d7b6cdd15cc7fbec676b9",
    "6dc86f11b8cdbe879bf8ba3832499c2f93c729ba",
    "67423ebfa8454f19ac6f4686d6c0dc731a3ddd6b",
    "63bf60c7105a07a2b125bbf89e61abdabc6978c2",
    "494179714a6cd627239dfededf2de9ef994caf03",
    "2c7e7c384f7829694282b1e3a6216def8082d055",
    "cff9611cb9aa422a16d9beee3a75319ce5395912",
    "e51f9799c4a21bba255cf473baf95a89e1b86180",
    "f741644ba6e1bcf5fee6d3c1b6177b78468ece99",
    "fb1d9241f67827ce6dd7ac55f1e3c4e4f50caa03",
    "56178b86a57fac22899a9964185c2cc96e7da589",
    "0a0315ec7b1e22a79fc862edf79bda2fc01669e3",
    "32af8a619c2566222bb0ba0689dabcc480c381d5",
    "d35b5afbc48a696897c084e6e71aae67c7cd9417",
    "602c63d2f3d13ca3206cdf204cde24e7d8f4266c",
    "a3c6fbe5c13e8b41fadc204c0cf26f3f214189f4",
    "25e480e9e0ca2b610105cd1424b8a35f63fb3981",
    "45412d51d3ca7bcf452d1612720ee88f9d2427c3",
    "ed6a95036e3e046931597a457db7a78b7309c4c0",
    "b4fe0256d346700783420e08a4a6f7992b1e36c9",
    "33e1799e98280e5a9ace5509477a2048607c5537",
    "cf193837f6de43f8e38000acfcf764fa8d8fde22",
    "7c8de247dda83599af2ec2ee2d29e20583dac34b",
    "f38a076f70613fc251c4d21e6435ad08341a8a99",
    "dcd68e6174bd74ba180da047a7345e8d111f85fd",
    "43bbacb5f62a0482cbdb564171b04365ca6e27c0",
    "ae5bd8efea5322c4d9986d06680a781392f9a642",
    "eb90bce364635c4c23b49f493f0043579bc85c17",
    "2942c7afa65444c43d0592d0dc73ca71db729205",
    "abf726f5fda729fb7f3f0484d7c94b3107aa02ae",
    "75db4f6bcc05a781dda9d17c46717286dd53654b",
    "a82cb42d89daf5fbc1d4a48476229c495782f98d",
    "fc1a69683744af823cd69e8a1e3f460591714028",
    "dc68db44b48521b0700a864896a00e17777aea83",
    "cc9ad99e917042381b0f99588896cbf236aa8ed3",
    "ec7a68484a749c7065c6b746f9c465dcb414f370",
    "c627c449deff14ae7ed807293d30846f061da5b8",
    "4782f2a19b6dbb0882d656de86c3d21a7317f768",
    "02d4eed99e7307bea39af5330bf7fb388d48b496",
    "b3d99b9d90a69e50fd4365704f5ab2eab7bc9763",
    "9b1c07176bb227f73e8a4e173071d39302061de2",
    "d79097ddac552a6e02a52ce7aaf494d2d73b2557",
    "df7f23b160e75b9bae5ea1e62b43a5a34a260127",
    "f598f3780d8c374d97957b9b62d56106e9e0b2d2",
    "0bd98598f9ab29c1359ef5460a206dd1370515e3",
    "e6c320834f69d81689e1ecd5abc808d49d9c4e07",
    "fd5ee7588cd129e12b886974621fd29facc78e19",
    "2a9c28ef61eb536d3bbda64ad95a132554be3d6b",
    "cfae6d86a767b9c700b5081a54265fb2fe0f6fd9",
    "8ae2d46729cfe68ff927af5eec9c7d1b66d65ac2",
    "636e2ec698dac903498e648bd2f3af641d3c88cb",
    "7cb1330f35244b57437539253304ea78a6b7c443",
    "2e780486f64bc91fbfa2785ec1ca5c9e3cc07939",
    "4a7713d44e97d9f09ae1d786199c58ae2bfaf3eb",
    "c98714b16f92c8a770e9fc229df834d1688e282f",
    "aace3dd6f54a2a255aba920f5ffc8cf04b85a69a",
    "cf8563896a3b0a0775985d8289444c4bbc478da7",
    "6d942da0c4392b123528f2905c713a3ce28364bd",
    "c6138d514ffa2135bfce0ed0b8fac65669917ec7",
    "69bd728ad6e13cd76ff19751fde427b00e395746",
    "ce705b7c60d46e7e36fe073db8822698579ca410",
    "c717ebbf6a2bf1bb33da6257352d5085bee218b3",
    "86151d140aafc9a4b5877d3fbb49014fe5906e57",
    "7446b5a6bbcc58bc9662451a0a747d7d031f9a7d",
    "c24887924f92adac5ae367995d12691c662b7362",
    "5af83cfd42d61967778889ca911cfb6c14339ba7",
    "587d4f6e6b4e21343423e434679009cbd3d24dcf",
    "ac65dd946c5cc432d4d624caeb53c7363f96b7af",
    "fa71e70750674c0f6b4aa19d0be717b2936c83fd",
    "c9efe6dd0a019315f73f3962de38b6c848a1705b",
    "d1d05649b952c8f6eb016be08fe1544aac5d5925",
    "cc3081ac1d695bae51cfd5b44b9fb3a230733cc3",
    "eb9de332558953792687d9a7f598b5d84bf0a46b",
    "39de5efdc92e3d3678f24d2cf545ba4d172d003d",
    "399dbc9f721e44a992a0def42d999b32af449adc",
    "996a2817c8acbc667e1c4c27b8f4e9952736dd7a",
    "3ef8189ce1bcc0d65aa182b1a81534635edfdf2b",
    "d676714c6a6ff4e17a60c0511c25aa8b164fa606",
    "4db6e3381e1b9290267c1539e1053793c8b81fa1",
    "3a34d35b0296fe4d83eda39b742a9d8f4b13a958",
    "54f3b45304ef1287f54b877fcce3285e154f9d6c",
    "b1ea96216e025377ab5aa845238fc8bc65dd60e1",
    "bc6c7488145485dede1ae1d43b594f0046bcda0f",
    "3d9a0619ecf88c84ce86213e9aa91d9a252cbc32",
    "92ccaa0b4ce89e2bd80a61b9bafd5ac58ab7b588",
    "3eb326b5bf4440fb3a88e3dcb05c1db5ea01ac5c",
    "989c63e819b13d4cadfb33f8deafbc57c1992a12",
    "ae944552c20cf16f07a5c357713832c9d72d0c6b",
    "46723e982569a1e2d9edced5498fc1f46f7d63fc",
    "3bc5dae7907c83a0693f87fd8372efdd1df53e09",
    "96d281ba44eb21ecfb1663c8ac5752c48686a927",
    "fa0ef18178880a72b51c26555c10f5210dab4390",
    "0c7ecac32b8ed6d9835d381bf069568722a276e1",
    "649e44ecba85c0938ec09229cee4bb69388ec642",
    "1e6634bfaebc0348298105923d0f26e47aa33ff5",
    "af2af2734bb2baa288940cb62109f4849daa347f",
    "22d14bc045cc9a3794c99beee7abe278bf24d6d8",
    "c3164ccbed75b82ed3f59f4a47fe09b256025549",
    "c27b5bc7cd24de4913614a769a442e9cc9fb0e08",
    "f44d48d98cac77522ff6b9e1b9cbb8489e58e588",
    "ea19a71ffbec9572f6cd65523acaf865ec05ab52",
    "cda0eb9d310247bd1e8b3ea10d9b9deff6fbaba9",
    "449dfce971b9d65d69fbc72940e9a885e8dde9ce",
    "96eebb6b95a9da99c58190cbd77cd6fbcf638a79",
    "670f7a869e90ce86e0a18232a9d4b1f97c1c77d0",
    "bc544e24573d592290fdaff8ecf3f7f2b00cd483",
    "e4ce142d09a84a8645338dd6535cbfaaf800d320",
    "1c26461e26eb697ccc36a98714ee70caaa87a84e",
    "51c5b1c25a71ff00394a84ab48b5733c8955551e",
    "84803504181c0ae33a511c49af5015a5b1892bfd",
    "7cc8bca120c2635abfea82dd203112b5c7e165da",
    "44e2519a529d7261f1bebedc8ed95e1182cae0dc",
    "2a81372da39c1df4251539a9922717b7cf5f0334",
    "41c89d06001bab4ab78736b44efe7ce18ce6ae08",
    "d3dbd653bd8597b7475321b60a36891278e6a04a",
    "3723f8ab857804f89f80970e9fc88cf8f890adc2",
    "d031c9fb7af0a461241e539e10db62ed28f7033b",
    "e0b550438e794b65d89b9ee5c8f836ae737decf0",
    "fb3998281c31d1a8eea2ea737affd0b4d6ab6ac2",
    "7a914d8b86a534581aa71ec61912ba3f5b478698",
    "a271f71547442dea7b2edf65cd5fbd5c751710aa",
    "89d7312a903f65cd2b3e34a975e55dbea9033353",
    "e6434bc401f98603d7eda504790c98c67385d535",
    "3352e41cc30b40ae80108970492b21014049e625",
    "6981ed7d97ffca517d531cd3d1874b43e11f1b46",
    "76382259107c56b3f798107a8acc62b32d8ec2c6",
    "548538582fd2e877b023be0611150df9e7ca99e8",
    "54152ac7d9f4e686e47d3a74d96229c33793d51b",
    "40e1b424cb6f13453ea005d077adb732b2fb9084",
    "a47fd7470c43f7cb7e5dd4159fb0c11644f6a108",
    "4ab5a4f084d4d95894078e8d570eb0bff13c6286",
    "5f9de1b34863866e2c644fee51ec0bed7d6b7d91",
    "2425097e0fea366d916d919f690e99cb6594d370",
    "1e2cf1d35240f0b37d056c69c18ab95559e311d8",
    "25fb08a7408a380b19074fa547f4fc4eb7d303b9",
    "e38c3774d31cd2ab4079c38abd7876fe1ff8c1cb",
    "e06dfc04b000d187b8bd6b539c884581e49a7b48",
    "027f9a54264ed75254e00c6a8f821630d780c6b3",
    "a86906b83ee8851520e2e628ab6295ce3497a2d3",
    "3ba5b1a7c92cf4e749995b819cea8c37e479f433",
    "e192f0d9326d7a0406b343d89e6c1b0bd1bbfb76",
    "e5c31d8a5d94c54aba514694cb0ddcd835b328de",
    "77237ee62b7ea8504451b6372289bba5d46d15a1",
    "11e85e204f22d0784746ffdcf8c5bc0b5de6a211",
    "6a2bc12e4605f27fce8c2e90a387e7dee901e48f",
    "8c696b02e3bd3f7fb02ff852ee8bf8d1d3c9c75c",
    "75a73cd24385a1e1768adddb23b3d7183cbb2f00",
    "3c1a0181f2b5d470bf78df6dd596d85f63e4d855",
    "0be0dc00e59482a360f21199abe9974a85047da2",
    "b853306aa29ebbea560c61eb1f9a2f740b45b6c8",
    "5e477b0a9dfe6225bdab510bd87bcecc59bc2497",
    "9112798181ba4cc1c528a70729cf784115ca69f6",
    "d741bec70d9070cee9960c5043a2773051e4cbaa",
    "7135cdf89a331ca5cf339d414a950afa9e2bd786",
    "aca27247604a6960e513b1eea56146bb4e443c47",
    "cee02aef5cb718ab5838c9673deb86f47f479f68",
    "cd024743ff967bf59d595461f549efe50ae155f6",
    "c100aaa2cc196af36fcdc403e99f04f357c88131",
    "2f33512a40135a515b68bf53b09844678c7548a1",
    "3416bd9a3f79dbc063fff2c25bbd760831bf49cb",
    "679256809caa8eb74c086b8c3a0e2d4abf850f86",
    "476d4a88a9dabdf50e65dfb207b7117ff9d6e2f4",
    "9af88ed103f83fab906e5851728b4d47c31cc5cf",
    "c0733dd1c6ff8f9b1463c3e3ddd299cd3f81d8f0",
    "5b19b45105657e67a75d290e52b0b12b7cb54fb5",
    "aa6cc574968f08a0a975fbc65ae1c673125a38b6",
    "1b3e6fa3c2a28bec0d42f4db58190bd393d372d4",
    "97019771490e12f6b89b581c7df82ec1e250652b",
    "37452dde0527a88d2beb55b5b98eebeceaa2b464",
    "5ada134688493c8ff0298563b6d37e0c2b820818",
    "27c194fd8566a2c5eff8d00a9ad2febf8105846e",
    "b692e7fdf82422566df39942a262647fc27544db",
    "a8df45ea509a4abbb0a9ed2af668040ab420ccca",
    "b9aa0fd55e3da81095d899e52d6427406779e6c7",
    "e308d9ea4b329e5ce3ae1ca31cdfc59b687cb7a7",
    "7366daa91f296da16fc931b8d820c671674c73b1",
    "b44ab5276973cfccf3b6e1b50f78d1dccae35e0b",
    "48a9d63f99faea8f26c8f9b37ae8650419767808",
    "356301d2c18c60cbf761e8820e78b2670a54ba83",
    "c82f43012f075b3be2018878d30ba404ccde3b5d",
    "b3d1e00b9f264ff969f7a16c6ae3901f9edb933e",
    "0446503bbb165ad4e747ebe9e040a550cf6ea1c4",
    "f4e0b1d08f68e38c83604fda8266535965955131",
    "38dfba530b2a3b77c25816472c44c03b7e32fe9d",
    "f079c4078b90472d5a6de034133e6fb6bbb16745",
    "453e806d74a27e554f2a3395ce7917919bf3bde6",
    "995b6f0c8f9eda20f3e5a2bd89df908747900008",
    "c7b4dbb98c78008fd53159174b7baadf250fa5a9",
    "2407f4de74bc711d0071476eccd73370bb6fbd0e",
    "56b81cf38a7ad1eb515a8e21af35b308f4977cfe",
    "de45d743c21cbe75d718086178ce454ced1dfa1a",
    "9dcc4b7304e7305639ff55e78bf538e6e4bdc847",
    "63cdae0a07072e387cdbcac4f73bfb0ed66432f6",
    "20431c9fd7ed84d31937901e6c2f2263e22f2915",
    "54d11e99127d159799dbce10f51a75e697780478",
    "b9ae613785fc3061f9df6a4f1e86e6252a6004b3",
    "366ab5426763b78563de648d831e6e8f02e16c4a",
    "b5a7a52b733421f97a37319fe3580a4ba2b86a11",
    "8ed72f03309e7ab31964e4dbfb25e8ab41684124",
    "5afd9a289b4fce41efb7a77a2baa9314f9f11cf5",
    "21d0451e21cae775b5f718886fd59b2ea9e9e787",
    "696cd0f2c8a6e0fce77fac490b70621a71c51e38",
    "5bcd7ae76d23e39340ef0a0f2fd38ddaa3b4b733",
    "0e68e78d5d668479992fd6a7ea2879f1c0b44403",
    "f93dbecda2f86c5c52936e986a582680bcc10953",
    "e9ef3322618fd7db744b674620bac1d2427c79e5",
    "2febe02de9105bf3ee4412c79c7c3df1044037ed",
    "4f60bb9f2c379b6c6b95003d54a4b4dae47889e8",
    "f2ce6d9c33c6dea70d4a6955f4d00fa8371e54d4",
    "c012e1bbaac2cb4b7074a859bb98e469177e1afd",
    "7c5c4cb81d270a5a41f7a41e6124e6028070ee97",
    "669702442cabc5b51604234fd8ef37062a6cf11a",
    "0b5febebdc3f4f31d6c5c52b83ef2a06c262ef8b",
    "cf5d815b01a6a3952ff81a688341222dcbb853fe",
    "845c71d2b20913850ef1fcfec5606412256639ab",
    "861c969227f1043620c9833c2580e64bf4cf52d5",
    "55241a343ca97a602f7a6c71183fe8976999651f",
    "1d298771d3d6c35899c5604660c1f6c77d1e71c1",
    "580cc8968318c3bf61ce62aa2ded2b15777de522",
    "65bb4da1216214d7962733a372e78966bdfda5d5",
    "17565818c45a669aa6bdd25a7c5c121120704731",
    "1ad5f3869d8b92fdc30b81b06e21b9be866e103f",
    "9b181c583aa16426c200931bfe5d4e6c269e6ca2",
    "60c456ecebd7834f3fa8d1f4307449bf41616740",
    "bd4c73a0a8748c627879652fad3761fd7ac36c4c",
    "0baa214b983e58e39ecec9bf2bd537a10b2071ad",
    "642c7c6166e4dd09183e1b32dfa62f6f3dfc8ad7",
    "9beb03f7c76da0de2bf22a08efd1e2bf07274f0d",
    "a0d8782e1eeccc7bb104a4c38f79f8541383fb1d",
    "1c1b52a04ac3aa838a3698395aa3d934784b4b50",
    "b844b4f08c5255fa66158fa18ad57154af1aa840",
    "c07f9c996bf7327dfb47c82eb6b8bda1af065e2f",
    "1b9fbff4d5a61741c90b6f040eac211285294510",
    "2e4766b0ebf480a027ae6f9e59e7a2ef9e2aef2a",
    "f7b8e5e76e6b4cb3dfa7af7070d5560400822b65",
    "54717f94e8f3ded40b4cc1a470eacb25cb10136f",
    "e2fce1365029e7d2e8c81f5b1f6c533629ef3752",
    "7d7bd28f79bfba1b69dcb45f81a423d1730b56d8",
    "1a17d4c4c689817bc9e5dce38ef79ea684eb8976",
    "1250a5f131121f1fc0aa77d3d6dfd641526f266a",
    "43c87ab4ed185c57ab3ccd9d89017897a4e77504",
    "5a7d9a1c26ef0cb99fa2d7e970b19ccf5a5e4229",
    "431e10ef7681217c353a54302c611661f5d8aa75",
    "c572caf20d5aa8b6a8faf99f6628594fe3ddf81b",
    "a1219d23a9efaaede86c392888a18f995b15e8e2",
    "be9a388016c3973d9b4a8d0c2c7fb9a6d254370e",
    "bb260e71e8bd5ed2baf5d9038600032669086ce3",
    "10fdd35f361b080323b86b47c893cfb13879c028",
    "154c3aed514692dfef86d89cf1dfbc4f8f1bfc92",
    "fa2c27c443e60a0bcd8a1eb82d20fec20759c03e",
    "4916d6bdb7f78e6803698cab32d1586ea457dfc8",
    "89d6d7a79dfc4c2588e5ba3726d163faa67c4249",
    "4bc7dfa199db2cc10d6fa1acbe2bea402c3f69f3",
    "ec485bc69fb3660cdd7c650a8da191c958273534",
    "1fb3afbdcd58e4edcd92c49f22d4caa0581749a1",
    "0183c0e82beb55c6b2bc24b89df5dd64b87d22d8",
    "d8dc481dbe69b312789e85b0284c114108a18bac",
    "296f1f75500286b9b4e5ac80fba1ea8452d40792",
    "205c3b9ed40f9f92a70e5920b85707f50689a618",
    "77ce91d45055ca41c52fa6f9a9c3117b2aee9611",
    "fe4c72354229cb1b9c9a05dde2ffa93ff6d12400",
    "48174534cef0fc3fec5b1a6dadfba2281c4195bd",
    "202413d6ea5edda76cd27e81f8700d0b379ef58e",
    "699b731a830041cc7afc2a0e8f48df1146abb75d",
    "3a5f338bf04229f9e45e1402988bd5c59dda930f",
    "8c620f2651c8ad1a40f4aa2fc0687848c6db1d75",
    "743fa8d2c15ddaa8923904ba6c2f61db15f5c71e",
    "ee065a446ffac9e405bc0e30b8a595d898fd8f57",
    "ba83d7ae664cde7a19ec33e839fa19b46beb7ee8",
    "0941612acd729027440f6aeac58ac28e18a44cda",
    "b4a3e1dab651d8e978abfa4c05c0cab1a33902f2",
    "30666bf53a5fed4b7d6bdbc993348e56144bb1b1",
    "f6a97e96436d9c5340009a497ba298d2901eb06d",
    "dc0b98a0d1d20b974885aac995d8c484d6594d4d",
    "62b3e62ba7f7194fed07c518179d0d86e4e20661",
    "699b84e119bffbbffa1a228e92682f1f394cabcd",
    "31ea9a067b4d9207bf4f4e4dbe3ce191cc754e05",
    "5b9ab97c102fcfb39efda8b788a4a387f18a507f",
    "a2f9fde34879a9e7f8caa9a21c2f2a4b47c24ede",
    "4201b2664b010fa180ec54c37d8615b3055f8a81",
    "84404983f08452a5ff4802e2f531602520d74546",
    "cc0ea7cd6b40fa790570fc767b363d1482718cb2",
    "0b0c30ce8a0770ee6a989e94bcf875494ed105d8",
    "6f5f7e81f4102d4f76c2604d9a0f028e49c4952e",
    "bab4994f3923af37ddbf54a1b69d5954852d1754",
    "2c2a9d56d09c676a7b6500d3ee18b6e100cbd87f",
    "58391cd702c86eec62fcfc9fbfff535410dfb150",
    "e3510479f43a21b29fde3504af668d37bdbbb799",
    "ac2369f558f15f080f68cd384fbe52f348a47e31",
    "e090b0bf8c1b9e7607962a8523f02d82e8cc12af",
    "262b8f0734bd8af3b42f21fefc9293a6c0bcf8d0",
    "a4f2c68beca4ab5b4b3db1ae9d07cd1b35f9fffd",
    "2ca39733f7a738c1fa8f515ffe2ff3ddc0c95c56",
    "63d16097c9b701d65b33700e05512bc905b58443",
    "bf77ecf143ceb21f1676c34b8d89c8bb3c43cc4e",
    "862e4228ab561c475192bdbd03bb33c743fc0734",
    "515e46b8fd51d614ca183cc8b3a076a9dbe3b70b",
    "15cd4acbc372d214f88c908c92903c7acb958e32",
    "26110861010beaef40f4590c701c0ff493f0ee27",
    "bf7e80ffa9cbda63f72be2b83d732730cb953e97",
    "d0900aeb1174173f7cc69d4788a61a574893d3b7",
    "e79a9ff141c1279cec57f7ea34d4ac4d057f0834",
    "a669f82976ca034e631533ce96e94b44e24dd2d8",
    "7aab0fd3799c01adc27018aebca9b3a0e1a3d7fc",
    "36248be03e0562a5306b30fcf7c4a4905cc41714",
    "6bf234d718fd1f27bbfbff81fb7fd64a22ae6745",
    "935ca3dfc9bfb1a3dccd5f794ab17e387441a4d2",
    "bb6ac0036ee0a56803045317744d4269ecfd0e62",
    "901406bf18a77ea00d526753957cb7423ee20b4e",
    "b0fe8f32582fa72bddd26dd9599c8205117c6789",
    "7d62100f74e829f7c5dd4db5817c530f3506813a",
    "713b4f3bb5a983590b7cb3d8b68aa56abb396cd9",
    "8e62281add5a87ba1b6df012b5fa25c7ec697265",
    "ebaa706a4823c278319dfcae0cb4a042d13eb39c",
    "c2e1fc39b890ff2b27ba8d0d355ef5704d792a8c",
    "eefbfce3c1c225bb429d0f5bc2552210373aa2d9",
    "4daea7d3291cdfb5bb13d522966c49bf1d692eac",
    "efd657e983cc85ba14c91f33fa81cb55413fbda9",
    "d33bce8f11c9f73666ae05446e0645235b29faf5",
    "c0c549f0976e53d790ea9fd14aedf0a0cb86a678",
    "44992a04e41a5cdb18833afe21a731c2b424b990",
    "6233b62e68349b3b17ffd9eaa7395b8521e31d38",
    "85d7f914b07ea2df148d5b1ed22f44928fce3a2a",
    "a2a0b0917c454ba4cb1ee2c61dda863004542ed1",
    "2411673903f84144bc5ee990f1b9160796196f1b",
    "6ee6dd69ff465b3bbd0c72048df09f001958419e",
    "c4493400da60de7e324dd0328ca5e3429d273c14",
    "a9ea2b10ea549303f8a5448f3921449ce25b8c36",
    "89725b40e71e1c0b27a68378a9e0ee0b2b0953b8",
    "cab92400df0b6b54e05d22b6ede2a2e5a623714e",
    "615653835fa024decf05ab5051fcabb4c6ecf853",
    "dccbb727546f111a22dbfe140aeb1ca04d74195c",
    "5d70ca252c600d686da9dd797018545aef3be66a",
    "a4b6a68e3b0e76d9d97b1323f8ebf752ab8b9815",
    "9fca700f9b8eb2159fade3e194a26a203270da3c",
    "69f3f034ffbe3f8881c47e96d8a3c25d108b0b39",
    "ccecfaa2c49a05caecd260b67e06b3db579aa0c8",
    "fc97a9f84b147b2244a9c68ed6e42a2b443102e9",
    "d64305c4b5c334fe9777f4a4c0c82389b289ff1e",
    "bc04cd94abdf3c177c38572e0b070cfdc6bb615d",
    "a96053be94fe5646d44c8455783180d5ad7d2ee8",
    "d34c409ea103ec1a7d54336149f33f3688fafff8",
    "660e49f0c60c8040ebfea6fbf9d4641bd29a50de",
    "2f8a580637446865145b7bc1f1376e5827966b47",
    "bca314aa8344c273ce31d86d05899c4dae043bc6",
    "c56453208571fd9c5ecb07451ef0f3b93e057ad8",
    "a238597192afa484d5c085938fe7e5ff5676c5e0",
    "7c033b565ec87dd7355c42a1822f4478db8a5a06",
    "2b0006ff2c586663fa9e60f0086ed31cbe263ae4",
    "07497ffe076d1c6ab3115f8762959763d03a661d",
    "5b886da6ce74d2392e79fbdf6573d37bd027e767",
    "946aa1664ebf30f0c8a5297d0307130943516e8a",
    "1fd32848d34600ec3dbec573897f6491f351e899",
    "caaf2320f61e4902e0a76275eade0b7b696df011",
    "188cf111bf5fac85bbd1234a725ae6d60c01b0be",
    "5a4b75efd596c4b63b585de8bdd7ba32e5c9d51f",
    "e6cde00bb218398b0746731df063d3bb566de2fa",
    "5eccce82721de36778dc60bc2202eba25330ac6c",
    "3f09e72b246a37847815cf6961c046fbe03a1b82",
    "e41218b9952ed1fdf1c13f4764ce0464ab84da09",
    "658e0bf69909da7ed06d0812743ea447f031ce20",
    "351df1eb81e4c608b0f3ab639b4535176417a65e",
    "8b1418a8864f2bed6f0a744d2a9bff79ce6e128c",
    "61300adab058879efab23bec70c679a8764cd61c",
    "c111d79fe3c572e5bb7b76665801304054f9460b",
    "dbd3d71d83e8eb20ee962d516bc649cf7611bafc",
    "3fd30a37347451c25842c635700d543a87159ec3",
    "cdab33892deced0454e1918813b95444c008ad49",
    "3e2e8c970e959b224f2333e4a9009b482e6863ea",
    "db4a493a3da552ed75be5fe0d96f6e99e2fd8eeb",
    "8b94a2c478e153ac9f5fc0b5de763b5124a1f70d",
    "465059936302a4b0f5303dee926a54c983701c2f",
    "4d2564abccc82edc1201f2f53975216586966c50",
    "0b0aa6cf662dcd77e54d3ad8f4f3dc5cc27151a2",
    "7918795cb32586b1e9e1024318e7eafa9b6ad18f",
    "35b1bc29234467f581fdcd1eab41d4f5b4e12b64",
    "abb9f092576cc104c714c930fc45ce4d64579119",
    "4b21a2a5f59effb24c569761e6d81190178b4ada",
    "69905ce9887ec25bba3431c58bc461cc198e216e",
    "9550962ede872cdba5c76e4edd01e0af82627131",
    "ba961c3cf1019b3ae55cf3cb4dfd63e56445a491",
    "1daa88cc7b906174701a12cd4ee99db16f0ce895",
    "1331b7f53c41c3af02675cf9bf9c90f766b15a66",
    "4c79f5e36122bdd75f0441394e17c47d1610398e",
    "47ca89f45df07b0cf76413b3e9501a673afaae92",
    "aafd8ad6f2e4fc8a62a62f9aa0e4b7dfe3ced4ac",
    "931dc6deca5a7bf14c7f09363b0128e7c2ed54c1",
    "2860821a19639a36f466d9b609c18d8b925a17be",
    "1b0833981cb628ba449413cf3b2298a2704aeb32",
    "36e77b3b717a5157e12ec0c31e97cd7206da5fa2",
    "de62d25749bd635d6bbe90c450277784a3c61cd0",
    "dc060bc4abac7f859ce49196440be380973875ec",
    "7f14938a411d1d43a518f616b89987754587e0a4",
    "d213475a442062ca792da0365b65013b91bce3e1",
    "568197b973327d6e1381fb787defb016554ff697",
    "0f487f25e2c6d326d5842469151decd377808c31",
    "944c6549c461c86e6efbb055ce984ce8cb477a3e",
    "5ab47b9585d9fb2479153f5ddb34df05d0d92d2b",
    "436104ec60d00a3d56f2715f4737b7a12141147f",
    "c4a4e308300110262019dbbfb4e3d8ba25b15596",
    "bc32be2415c6c9f7166cd72244aaebdb683ebc58",
    "283d86c470fead74c4bf994cba027f7edf596747",
    "7f387b0c27f3b2b273f85eaa35a93bf9d06d8a10",
    "92aace99c76e474bb8adcba0a875b477fc360885",
    "bb1cd0c8e0513222e530aa4e1f276cd3b13372ab",
    "b837ddcbc1eb7084f3c28b6e05bcdb3fea844b56",
    "d9a19e686d6c77640b10823a49e51b4eb8f51ee5",
    "198d0a35c25c67b817f4851f5ce0d0056259fdc3",
    "b5e6beb43c52ae185e2599db1927db7744335adc",
    "761dc03843153110601ae87b6e36dc29ace16ef6",
    "a64e92f4a324ad3ba3a116d561bd89036bc9eb71",
    "18dc53328d39feb8cd31c172e1695093ceec915e",
    "ae6082492d71f0ef80b402858803602ca3458153",
    "ec6f78c1620e0bda60f630f36015226ac8639b25",
    "c05239ff738a997fadd46525bf739e3e2c040e89",
    "707e83ce4291c118051c5191e888c283b4e98399",
    "cc14800d9ac3ef0c1f6731c9e70c7939c8dd0870",
    "c5294dbe82ede53a2d8bb0418503a2deba2e4f3b",
    "0455262dbd4b71218ed20f4162bbd0c3b7de4d07",
    "6ccb4f7070d3c908830645cd552e3d6112d059c4",
    "3974fab667fb7d746d5f088c6e277bfeee8128e7",
    "065742e2a66d88b5652b2e40d46c4d50102f6db3",
    "07fa47c9f269b323557182c61f6f6ed1c16ccafb",
    "196987fbf33148ae33ce9f9733a97ea845cdc1c4",
    "8139864a57098a32915f0e3aa6c0322fa9459fb6",
    "1fcbf41589c8e7d92274e64ae6ed3ad9016c179d",
    "055a0c549e6f648794cc65bddc08cfefffccdf9b",
    "f956af32d67df97f6534357de15b216cc2d2d102",
    "d7fea5323eea433ddb6277228ec0a5bc1ab4a808",
    "083c9487c4469fda257aa45c8876ec8269aeebd8",
    "9e88e459135e5f0b52ef6c371cca04a39d54b90b",
    "b8c1ee8246d14bd62e5a03b94b848b534613e7d2",
    "d26b97682f8acb1daf78be8c4418a0ebb17a05b4",
    "68f2b5a79ddb450cd1b4d5d6e502979c9f157996",
    "629e969018aa82b56389a3e601ef2a209f07cf07",
    "2dca01e39393889210c566779afb65048a387785",
    "d51c2f00f8c0fa2484497abe1bf85689c45d42ae",
    "467dd26d49785595bba3d406de25f5df8fd8fd4f",
    "72f9f715ea0aaf529be15e6afd7388e02341af75",
    "25a5435435d5020c5a7cbbb84d3f9b5e8b2fb9fe",
    "059d91ec492b6051340704b240b282d1fbe3d114",
    "33fd244ba8454d234e7d6a8d04a55b78eff890c5",
    "7d008c2d8d47bb97fc5dfe3de4559506e7fc4708",
    "860ddab2982e9dac6cdd1e19f5c6c53dab82e4c1",
    "4e39274189149868840fe7832230aa66483cd72d",
    "c61b506b45d98fe6ce5422f8edf6f8bde43fd2df",
    "97a8be86139d2732a9009525dff7cf77781acec1",
    "1e83aad8918c5002eca3b07b071045d23a7213f1",
    "d58d9ff6d19bd47651f3e2c766f869e6e07776ff",
    "edbb172dc2004b81bf3937a0d3e54ea5ed642da1",
    "1b144f648322f58caea9d31b3daf5ed686a3305b",
    "0662edf0d072a4efcbb94fc855a35b0631007eff",
    "446da0ba13c0c8cdec5dcb55beaff62f83822af7",
    "3ecdc37d6ba572f691cf42654b182ce0cf4853e0",
    "b9cf503328fc20919109b57a7785dbb664b2710e",
    "8519d7c98bc7b7610ee96c047fb71ba73a441ca4",
    "897e381dc5bac1eb7e8756dde6adae3ef2a081b8",
    "8d1f32ea054e1d02370eb02c8ddd67bafd4138b2",
    "d08fbd377a7f3689f881049f8c999e8c3616bdd2",
    "ef9c6777079358192b922616871f6e6762d5a05a",
    "63e2d52b6704f4660c1b6662a67acf385b4fb3cf",
    "9fd8b020a14f2dd4be4ad5de13352ab8addbedaa",
    "4481cc23334be067c5dfe87bffed1a1557fb5f64",
    "dbb3e3d67acf2807afce8e9cdc3f670b1cfb67c2",
    "0ab84832b324391f111b796e18dbdbf2c640f89f",
    "742672e86dc79921ad0551daaa134baecb1f81f6",
    "768e50efa6303a32043f7417f3360ffc3c9d4ba8",
    "4fc6247f63a71000a794758c3d266d42acd39758",
    "adfbec37138f84c212aab558a83e40570a349e1d",
    "b8725701da5bb62ed2371788edb05daa9b42799a",
    "10a0fe5f359d0f7bdcf10ed843b06a73338fa086",
    "a30f11be717bc710d4d6dbfa02da4767eec14fc1",
    "c0f1aba4346f0aca89f3ced0822af676a6835e87",
    "89399c4a03e038efb7a97fe38ab3f6604f1fc37e",
    "69ac5e45377465de71eed8a5527d7542130d8b2c",
    "69a5899a88ad3922168116e523a59a19f5fdbe63",
    "4da263905ead1900d957e11a24165aa5364da10c",
    "b3f980c9a1a5939c21865e1430cdb6514c9f0787",
    "195c2807c4b178c8d357d48560b759c70a5e1912",
    "f5527b7bdfa0eb61b5b399c8a92ef72bcaa1dca7",
    "60acf171a06b799678aa04c5ad2b999eba84f2e8",
    "c357c94e288185c8c29ec2af829d159d296d5907",
    "a7dc371d6a10326870be46b2cdf54803c4f05f2e",
    "1f5e0cc507a3f9749d8c6377663626bd31aaa99b",
    "8f352137a1e22f329086dd7b429049c7a8038718",
    "879c2e232949b8ec6c9ee6529ee39d5dbc502b8c",
    "aef44d7afe612259094ccd60494193225954bc51",
    "1fdadca3d067bcc8db56715a9a492dfd2d4f5b3d",
    "3b70d3d1cb0646f288537ed2695696c10b64d41b",
    "8188a5ccd6e88caaf801c0373283c18a0b315bf9",
    "75ebb8907480f01839e972a91051eccdd001619d",
    "0ec661c8aa7e106c4e03acbcca84c3cd8eaaea6d",
    "97da3e33e17f41d2187825d377bf0994c1631f89",
    "5f7c53e4006f76cbd1777b01005d03482d616f75",
    "50750f6ec4bdaa134369299de53d8d8b87d1ba63",
    "5f8f7e823d4e54b02610108a86ea721e337864ec",
    "d6cc685ba7b6ac3157adbb44c3f24c5a3c01ea67",
    "61e297c05feecd9901ec06b314429fe6ca92f27a",
    "d64a178d4759b796ec0e77626cf19257c28292fc",
    "6ae457f71b1cd60b1810fd4379c90bb38154568f",
    "063623280f208df296895ccd867dab8a73cf174d",
    "7a8b8c9aa0591603cf08e94ec2ae6a6350cbb8a2",
    "20c4232d3066c41e211eefe2834db78a8c083ea4",
    "82fdf2cccc77ab556aa35557d0923b162d1b98cf",
    "3dce8306f3c1810d5d81ed5ebb0ccea947277a61",
    "11bca5b61fc1f6d59078ec5354bc6d9adecc0c5d",
  ];
  for (var i = 0; i < expectedValues.length; i++) {
    var hash = new SHA1();
    hash.add(new List<int>.generate(i, (j) => j, growable: false));
    var digest = hash.close();
    expect(expectedValues[i], bytesToHex(digest));
  }
}

String bytesToHex(List<int> bytes) {
  var result = new StringBuffer();
  for (var part in bytes) {
    result.write('${part < 16 ? '0' : ''}${part.toRadixString(16)}');
  }
  return result.toString();
}

void _testInvalidUse() {
  var sha = new SHA1();
  sha.close();
  expect(() => sha.add([0]), throwsStateError);
}

void _testRepeatedDigest() {
  var sha = new SHA1();
  var digest = sha.close();
  expect(digest, sha.close());
}

void _testStandardVectors(inputs, mds) {
  for (var i = 0; i < inputs.length; i++) {
    var hash = new SHA1();
    hash.add(inputs[i]);
    var d = hash.close();
    expect(mds[i], bytesToHex(d), reason: '$i');
  }
}
