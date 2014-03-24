Return-Path: psusi@ubuntu.com
Message-ID: <53303927.1030004@ubuntu.com>
Date: Mon, 24 Mar 2014 09:54:47 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Janani Venkataraman <jananive@linux.vnet.ibm.com>,
        Karel Zak <kzak@redhat.com>
CC: amwang@redhat.com, rdunlap@xenotime.net, andi@firstfloor.org,
        aravinda@linux.vnet.ibm.com, hch@lst.de, mhiramat@redhat.com,
        jeremy.fitzhardinge@citrix.com, xemul@parallels.com,
        suzuki@linux.vnet.ibm.com, kosaki.motohiro@jp.fujitsu.com,
        adobriyan@gmail.com, tarundsk@linux.vnet.ibm.com, vapier@gentoo.org,
        roland@hack.frob.com, tj@kernel.org, ananth@linux.vnet.ibm.com,
        gorcunov@openvz.org, avagin@openvz.org, oleg@redhat.com,
        eparis@redhat.com, d.hatayama@jp.fujitsu.com, james.hogan@imgtec.com,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        coreutils@gnu.org, procps@freelists.org, util-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/33] [RFC] Non disruptive application core dump infrastructure
References: <20140320093040.14878.903.stgit@localhost.localdomain> <20140321080855.GE26374@x2.net.home> <532C54A3.3030903@ubuntu.com> <532FFE3A.9060002@linux.vnet.ibm.com>
In-Reply-To: <532FFE3A.9060002@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 3/24/2014 5:43 AM, Janani Venkataraman wrote:
> Gcore attaches to the process using gdb and runs the gdb gcore
> command and then detaches. In gcore the dump cannot be issued from
> a signal handler context as fork() is not signal safe and moreover
> it is disruptive in

You can fork+exec from a signal handler just fine.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTMDknAAoJEI5FoCIzSKrwo2QH/RCmAn404PlO6cZLNuQ5PXqc
MdR6U62K/BwZo42Fr694FzzjGKwuqx3YHB8gU+tyE26yZ31reFWG8KpdfV46NRYG
sEPH/lJOerMXwfbpxE0YFZBow5wZqTg/XsiXMyz8M4/KdMgOgCEqsaG/IRPvK0+B
NiaQmFct0Y2onwoy50mrR2sGeKOgA5510osoChCq+TKUrsCJp80jYvz6bVOi6kwY
Oi+bAl/tzcQDy7yHkUqYJXYRf3o9jbHqGxnC/IzygOntggqmIiB8ez4ZDZC2YbOl
htv0gP/jqZk8Pm3C/gv5S7xhqjy2+yvkWXg7mhsz7gsbSA4K5LXd5bN5ovEBGAw=
=JWwx
-----END PGP SIGNATURE-----
