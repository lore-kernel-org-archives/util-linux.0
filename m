Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:47911 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295Ab3ALFNO (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 12 Jan 2013 00:13:14 -0500
Message-ID: <50F0F0E8.2020909@ubuntu.com>
Date: Sat, 12 Jan 2013 00:13:12 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Mike Frysinger <vapier@gentoo.org>
CC: Thomas Orgis <thomas-forum@orgis.org>, util-linux@vger.kernel.org
Subject: Re: losetup -d --force for zombie loop devices?
References: <20120417100346.2a0b8301@orgis.org> <201301111852.03607.vapier@gentoo.org> <50F0B438.1080608@ubuntu.com> <201301112352.55112.vapier@gentoo.org>
In-Reply-To: <201301112352.55112.vapier@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/11/2013 11:52 PM, Mike Frysinger wrote:
>> but my point was that what you are looking for is umount -f, not
>> umount -l.
> 
> and my point is that `umount -f` doesn't always work which means
> `umount -l` is sometimes the only way to remove a mount point.  an
> unresponsive remote or something is holding open a reference (which
> doesn't show up in `lsof -n`).

Right.  Forced unmounts aren't really implemented.  They need to be.
It isn't losetup that needs to be forcibly detached, but the filesystem.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQEcBAEBAgAGBQJQ8PDoAAoJEJrBOlT6nu75dGsIAMTb/fK1nw3QZGyWKmHQWknA
AdOXe8aYqIzKTwhGCrJobamAB5ZOqEXWCHZnMfACI3/XwTfy6vNxKa69fIEevpXz
uNU4QO1dw8uLRBi3UQpoTSNZpx4vB8DF9ka1GxgEUs7Y0Iv1I3n2OoHnU1o/GUE9
HHeA70QSSIJaO7hUB5Q9mb5brx5ADP+GS7Ka7ZPDVFjdImBkS9ofOj3GX8aLWf1Z
kgkxcChgEtZPc1xrp15l8ctAvI/sQnev+DQ4SmzFdmDGqEwEBNP5ROm/W+B2bNkC
L1RdlOEhOwQvdWcjer1W3Mkl9MuhSzcmW4GdaepndXzuJYQ0VQqURSPSdBxueLY=
=qhyJ
-----END PGP SIGNATURE-----
