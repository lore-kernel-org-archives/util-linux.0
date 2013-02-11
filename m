Return-Path: util-linux-owner@vger.kernel.org
Received: from blu0-omc2-s33.blu0.hotmail.com ([65.55.111.108]:43862 "EHLO
	blu0-omc2-s33.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751936Ab3BKBpE (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 10 Feb 2013 20:45:04 -0500
Message-ID: <BLU0-SMTP144C815AE93C94E539C372CD50A0@phx.gbl>
Date: Mon, 11 Feb 2013 11:44:55 +1000
From: Luis Aranguren <pizzaman@hotmail.com>
MIME-Version: 1.0
To: kerolasa@iki.fi
CC: util-linux@vger.kernel.org
Subject: Re: Hypervisor & Virtualization lscpu test fail
References: <BLU0-SMTP36414270EB979DF67318E53D50B0@phx.gbl> <CAG27Bk2XQxWUFZPuQP8JWJaJ5OuCrxspk==9saGO-Xv6yk=7Sg@mail.gmail.com>
In-Reply-To: <CAG27Bk2XQxWUFZPuQP8JWJaJ5OuCrxspk==9saGO-Xv6yk=7Sg@mail.gmail.com>
Content-Type: multipart/mixed;
	boundary="------------050202080808060803070807"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--------------050202080808060803070807
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 11/02/2013 7:04 AM=2C Sami Kerola wrote:
> On Sun=2C Feb 10=2C 2013 at 4:25 PM=2C Luis Aranguren <pizzaman@hotmail.c=
om> wrote:
>> Hi=2C I'm trying to package util-linux for exherbo=2C a source based dis=
tro.
>>
>> util-linux's lscpu tests fail when compiled on a VM running under a VMwa=
re Vsphere esxi hypervisor.
>>
>> #cat ./C/64/tests/diff/lscpu/lscpu-x86_64-64cpu
>> --- /var/tmp/paludis/build/sys-apps-util-linux-2.22.2/work/util-linux-2.=
22.2/tests/expected/lscpu/lscpu-x86_64-64cpu    2012-10-15 10:09:42.0000000=
00 +0000
>> +++ /var/tmp/paludis/build/sys-apps-util-linux-2.22.2/work/C/64/tests/ou=
tput/lscpu/lscpu-x86_64-64cpu   2013-02-09 03:35:37.000000000 +0000
>> @@ -12=2C6 +12=2C8 @@
>>  CPU MHz:               1064.000
>>  BogoMIPS:              3989.44
>>  Virtualization:        VT-x
>> +Hypervisor vendor:     VMware
>> +Virtualization type:   full
>>  L1d cache:             32K
>>  L1i cache:             32K
>>  L2 cache:              256K
>>
>>
>> # lscpu
>> Architecture:          x86_64
>> CPU op-mode(s):        32-bit=2C 64-bit
>> Byte Order:            Little Endian
>> CPU(s):                2
>> On-line CPU(s) list:   0=2C1
>> Thread(s) per core:    1
>> Core(s) per socket:    2
>> Socket(s):             1
>> NUMA node(s):          1
>> Vendor ID:             AuthenticAMD
>> CPU family:            16
>> Model:                 6
>> Stepping:              3
>> CPU MHz:               1497.506
>> BogoMIPS:              2995.01
>> Hypervisor vendor:     VMware
>> Virtualization type:   full
>> L1d cache:             64K
>> L1i cache:             64K
>> L2 cache:              1024K
>> NUMA node0 CPU(s):     0=2C1
>>
>> How can I solve this?
>> Luis Aranguren
> Hi Luis=2C
>
> I have a hunch best way to proceed is to get cpu data from your /proc.
> This can be achieved easiest by running a lscpu test data collector
> script.
>
> cd src/util-linux
> sh tests/ts/lscpu/mk-input.sh vmware-esxi
>
> After running the script you can find file vmware-esxi.tar.gz in
> current directory. Please send the file to mail list=2C and inform if it
> can be added to be part of regression test suite (which would of
> course is much preferred).
>
Hi Sami=2C

Thanks for the reply. I include the output file from mk-input.sh=2C I have
to note that there were a three permission denied instances.

# sh tests/ts/lscpu/mk-input.sh vmware-esxi
cp: cannot open =91/sys/devices/system/cpu/microcode/reload=92 for reading:
Permission denied
cp: cannot open =91/sys/devices/system/cpu/probe=92 for reading: Permission
denied
cp: cannot open =91/sys/devices/system/cpu/release=92 for reading:
Permission denied

Feel free to use it as part of the regression test suite.

Luis Aranguren
<http://paste.luisaranguren.com/index.php?8px@raw>

--------------050202080808060803070807
Content-Type: application/gzip; name="vmware-esxi.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="vmware-esxi.tar.gz"

H4sIABYlGFEAA+1dW3PbthLuq/Ur+HjOTOLgwoukmT4kcjvH06TtTNuZ86ahSMjiVCJ5SEqx
++sPlrIcWopNEpI2arHfJLANEhdi+QGLxQLcrD6HhXqryvvk3XdnAtMIPK/+qbH/s/6dC858
JoQr/O8YF4z73zneuSrUxLqswsJxviuyrHrtvrbrf1NsGvIvH8qzvAMG8velS/LHwL78Y7VJ
InXa96C//F3hEf9R8JL89e+VWp3mNegvf0//SvLHQIv80yxWR78E/eXveyIg+WOgi/whYEe8
Bf3lH3g0/uOgu/yjfL0Kc5MyQMCu674sfyGey1+wAOTPTv2wX4Pl8t+J4M3jTzn41jUiYKKF
/5r0x+uABuO/DDj1/xjoIP+8UKVKj3j41v6fufvjf+BT/48C9pZTj28xOvD/T1WkajldhfeG
ZbTzX+7rf65kxH8M+KTwWY0O/Nf/+VFKoMH8X7ik/6Ggq/xrG4BhGbX8g6C7/PUP0P/F9fU7
/e+LDeKkT/4Ikn8n+UdhtDC1BPfmv2CSkf0PBf3kn6Sxuu9tCu4vf+4GkuSPASP5lwudJp7q
C9NlUrY2S7v+v2//dT2P5v8ooNm/3TDi/1Jt1LJ7Gf35Lzwuif8YIP7bDSP+p+vVTBXTbD4t
VVW2ltHOf3d//HcF2f9Q4HFBPYDFMNP/k79UjzL6819In/iPAt/9ifhvMYz4Xz3kp+W/d8D/
gPiPgpuwCqkDsBdG/I+yhSpUGj1Ml0mqpm3qQDv/99f/PVd4xH8M+C6x32YY8f9z+FDC7D8s
yyxKwirZJNXDy2X0t//p33ziPwZo9m83jPifLx7KJAqX2+E/D4sqqZIsfakMA/5Lsv/hgOz/
duPY9f8uW8Ja+X+w/8sl+x8SdiLY7f8ifcAuGPBfoPh/eeT/hQEj+WP4f9H8DwWk/9kNI/5j
+H+R/RcFpO/ZDSP+n9z/a3/913UF+X+igOvGpi7AXpjp/6f2//IP/b9o/wcKgP/kAWYvjPh/
av8vfrD/V/o0/0fBH2kyT1RMPYClMOI/hv9XQPzHAPl/2Q0j/p/c/2uf/z6TnPiPAe4T/22G
Ef8x/L8E8R8DtP5nN45d/z+b/xfxHwU7EZD/l50w4H/vwyDhvert/0Xnv6HASP4Y/l/k/4EC
0v/shhH/Mfy/aP0XBcR/u2HEf4zzv8j+iwI6/8tumOn/COd/Ef9RQOd/2Q0j/p/c/+uQ/wHx
HwW3aVkV6wiW76gfsBBG/Mfw/yL/TxSQ/5fdMOI/xvlf5P+JApr92w0j/mP4f5H+jwKy/9uN
Y9f/z+b/RfxHwU4E5P9lJ7ryP88+qwLx+590/hcOuso/S0HXMysDBOz30v/0cEHnP6KA9D+7
0Vn/K8JyMU2zSrX7e+yj1v8Oed9Y/+EH/r8e+f+jQM5D6auAUTdgJ7ryf602KjUkQNv474v9
83+YG9D6Dwo+/XLz/uPt+9++vx/6WtBjLeU4K8agk43n4SpZPozhfJbxKovVEqL98VyF1bpQ
4ze7eSOHQEAgIXAh8CDwIQggGEIwguADBBMIbiD4AYIf30AZEEBWHHLhkIxDMg7J+HsIIJmA
+wTcJ6BIATcLKFJAkQKKFJBWQFoBaQUUKeq0UKSAIgUUKSErCVlJyEBCWglpJaSVkFZCWgnJ
JCSTkMyHm324xYda+XAhgKwCyCqAqwHkEsAtQ7gwhAxGEDeCDCYQN4GKT6DOEyh3AlcnkGIy
GiB2xl35X2V5tszuHkymgP3nf5xzmv+hoLf8o6yAFf+Zng7edVQFa/2vl/1P+qT/4WAngp39
T5IiaBV68/9p7S8Poz/DOzVN4rYyWvl/uP8vIP8/HNDEz24cN/532v5rsv8nYLT/FwXsLVmA
bUZv/leLQoVxrx6g//jvCTr/CQfEfrthNv636/xN9Oe/cCXxHwXEf7tx7PjfpYz+9j+X0/wf
B/v2P/L/swtd+b9KoiKLslgZLADBe9Vz/UcwWv9BQX/55/qnKsusmM6XYacBoO7/X/P/ObT/
SEbf/0IBuycLsM3oz/+NKspXNnt9Ba3854fnvwV0/hsK2D0HCURD6gWsRFf+l+vZNsqgjFr/
C4Ie+p/0wP9PXF+/e/o3W5dQk5M3gOX87yD/Y7b+1Oit//PAE6T/o6CD/I/Z+lOjHv/7rP9q
+Qe0/wcFtP5rN7qN//NC/c98BOhv/wFnbOr/MdBN/uyY4d9k/Bew/5Pkf350lX+qp/6m43F/
/R8cwJ70fyj6qPJfBcm/k/y353+YlWHQ/9f2X+L/+dFP/vX5L70Hg/7y524gSP4YMJI/xvd/
aP0HBbT6YzeM+I/x/R/y/0MBWX/shhH/Eb7/w+n8XxTQ93/shpn+f/7v/3jEfxTQ93/shhH/
T/39H+Ydfv+L+I+Cm7AKqQOwF0b8x/j+D/l/ooC+/2M3jPiP8f0fOv8DBTT7txtG/Ef4/g/Z
/3BA9n+7cez6/7m+/0P2PxzsRLDb/0/9gV0w4L9A8f9yyf8LA0byx/D/ovkfCsj/y24Y8R/D
/4vsvygg+4/dMOL/yf2/9td/XZfOf8UB141NXYC9MNP/T+3/tf/9LyF92v+BAuA/eYDZCyP+
n9r/ix/s/5U+zf9R8EeazBMVUw9gKYz4j+H/Rd//RAH5f9kNI/6f3P9rn/8+k3T+Fwq4T/y3
GUb8R/D/EvT9BxSQv4fdOHb9/1z+Xz7xHwU7EZD/l50w4D9H8f+i899QYCR/DP8v8v9AAfl/
2Q0j/mP4f9H6LwpI37MbRvxHOP9LkP0XBXT+l90w0//Pf/6XT/xHAZ3/ZTeM+H9y/69D/tP3
n3Bwm5ZVsY5g+Y76AQthxH8M/y/y/0QB+X/ZDSP+Y5z/Rf6fKKDZv90w4j+G/xfp/ygg+7/d
OHb9/2z+X8R/FOxEQP5fdqIr//PssyoQv/9J53/hoHP/X4TlYppmlWpf791H3f8fyr1h/+UH
/n8e+f+iQM5D7quA3MAsRVf+r9VGpYYEAIr7r+h/vtg//4O5Adl/UfDpl5v3H2/f//b9/dDX
gh5rKcdZMQalfDwPV8nyYQznM4xXWayWEO2P5yqs1oUav9npjRwCAYGEwIXAg8CHIIBgCMEI
gg8QTCC4geAHCH58A2VAAFlxyIVDMg7JOCTj7yGAZALuE3CfgCIF3CygSAFFCihSQFoBaQWk
FVCkqNNCkQKKFFCkhKwkZCUhAwlpJaSVkFZCWglpJSSTkExCMh9u9uEWH2rlw4UAsgogqwCu
BpBLALcM4cIQMhhB3AgymEDcBCo+gTpPoNwJXJ1AislogNgZd+V/leXZMrt7MFEB++t/nHPS
/1DQW/5RVsCK32yZpHcdVcH+83/pk/6Hg/35vyRF0Cr05v+T7T8Poz/DOzVN4rYyWvl/uP8n
IP8fHNDEz24cN/532v5n4v8fMNr/hwL2liz+NqM3/6tFocK4Vw/Qf/z3BJ3/ggMa/+2G2fjf
rvM30Z//wpXEfxQQ/+3GseN/lzL62/9cTvN/HOzb/2g2YBe68n+VREUWZbEyWACC96rn+o9g
tP6Dgv7yz/VPVZZZMZ0vw04DQN3/v+b/c2j/kYy+/4MCdk8aoM3oz/+NKspXNnt8Ba3854fn
PwV0/hMK2D0HCURD6gWsRFf+l+vZNsqgjFr/C4Ie+p/0wP9PXF+/e/o3W5dQk5M3gOX87yD/
PCthtt/nxI/naJ3/H3z/UY8I5P+JAvZW0pTfYnTgfzafwz5f8zJ6858HgQiI/xgQxH+r0YH/
qywOl0nYf9/XDm389w/O/2Kc/H9wQNs+Lmfbx7eQf7f5XxIvTQz/j6jnf/32/zLuk/0fAz3k
H62LQqXV9C7bqCLNimmRdSuj//zPZZLmfyhYqXRN+p+9MOB/XCS6A+hRRn/+i8Cn+R8K0ixV
xH970YH/x2z9r1HP8V7lP9u3//ic/L9Q0GX+f4TrTw0D/V+C/kf6//nRlD949pjP8l5Gb/lz
Pf5zkj8GDuQP66wnLqO//KXnCZI/Br4q/zxKTvkO9Je/KwX1/yh4Uf6PisApynh9/icC5u+v
/3kB+X/iACRwNWRDP+AjdsWunOf4h0eEd/ldWFRvk7RSy4FuiuGuLbh1bTGABZDHx+f2vQrw
+KPd4x9In8/3IuTc37sj2L8jeH4HZxHvX7Hh8XfwLo//6+3tf6e3Nz9AM8x2zSCvRhcjH5wI
ePz5FffCmAUu23t8zoZfJBgN69HLxaiY+zxCQJ99lmIHsHy5fXyXeQePH395/Hg7eA8b7bFt
kGPq4T5qBK+8wNtCmnkcX+wuF3j8IbuqHaKZ1L885yt32TPxu6+LX98her4gkOPw4GH48wjR
+rjtdxxGQNFXq7wq8wRa4fElCCzUCfTjh7vHD9mVaO+B/1kRWvlXeVZU0A6jRjvYNhQ02yFs
tEN4MTXEiWi2w6zRDrOLqSFORLMdokY7RBdTQ5yIZjvEjXaIL6aGOBHNdlCNdlAXU0OciGY7
zBvtML+YGuJENNphxr60g7ycGuJENNuBN9rBYPL7t45otoNotMP+7OaCqnyWiGY7yEY7yIup
IU5Esx3cRjugWBAuKKLZDl6jHbyLqSFORLMd/EY7+BdTQ5yIZjsEjXYILqaGOBHNdmjYH6TF
9odZw/4gLbY/zBr2B2mx/WHWsD9Ii+0Ps4b9QVpsf5g17A/SYvvDrGF/kBbbH2YN+4O02P4Q
NewP7uXUECei2Q4N+4Nrsf0hatgfXIvtD1HD/uBabH+IGvYH12L7Q9SwP7gW2x+ihv3Btdj+
EDXsD6699gfBdvpDoDuK048Xgn2jwVh0SbJeRMl0EcXQDlt/SM6YViy/jBfRqM2zR9/RwTkM
jjl4+Y546B54NrV79vAuvj8tOuE2DwU/dCPw7cvAR0Fw5Q6bj8ix/N/2Ityz+b8dRJRpPF3E
4fTRQVjwnWUueOYeBo2BWKvmXxyvWLVjxrd2WiecDAf7P2C3fzrveLJHN7y+/4NJFhzu/3Hp
/A8UPJ3mfjV22GB7DNQ0ifVf79fVQqVVEr3/dDPQb4WzPRdKX+H+oD4X6kr//virk4YrBYk+
3Ti/r4skS/9Vrf7t3N46P6vM+dllH52bdbh8O8kK5fy6K3NQVirPk/ROp5SDp33GUJWnY4mh
5E//+QvK4u4ouPaYP4jCaKGcMvkLbuVMuM5PHwa7D5M6de3ZYPeFEv2HGMBXi+BCfQWyhIjt
pTBPot2VJE2qRGfxGAdR83wN1x5UCb9O1X2k8ko/32NcfTiGs1Qb3Rxjxxt8zp/uhtPx4Q+d
zNmslBMrJy+VU5WRsyoLJw+Vs4qUE90P6/KcUuXOqir0lTu4EjrRKtvo2ypIJn0nWs6X63Lh
rFb3zvxe51Dq3PR/4Swqp3wo9bNrOdzDdXVf1bdMs7xyilgXmTvLlSPjNPsM1+pfdBuk+uVP
qylUqVD59C7LYifN8iVUclqoZRLOlkrH6PuyvL4tTxNdY+47eZZHaeUsHnJVbBItTGcZLuZT
XYouoH6ecLaC6rmhs0rKcJncpVDhuui8UHNVRQsnKzefB7PsLlsleS2O0ci7Znzw+8cPz+Tr
/qQb4g7a+7ERHi/67vZlmNb5r/T7uo0M41jLt6xvg3xd5sySqnR2L8kbxx1uYzZJUek3c5Dr
limcVZjqYiCf8WDQ5Aa3ghv8RW7wQ25w4oa93PjW4xaBQCAQCAQCgUAgEAiE7vg/zVbIvgDg
AQA=
--------------050202080808060803070807--
