Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:61495 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753977Ab3KHOhI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 8 Nov 2013 09:37:08 -0500
Message-ID: <527CF712.90809@ubuntu.com>
Date: Fri, 08 Nov 2013 09:37:06 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: Generating release from git
References: <527C3112.40904@ubuntu.com> <20131108090906.GB10401@x2.net.home>
In-Reply-To: <20131108090906.GB10401@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/8/2013 4:09 AM, Karel Zak wrote:
> On Thu, Nov 07, 2013 at 07:32:18PM -0500, Phillip Susi wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA512
>> 
>> How do you generate the release tarball from the git repo?  I
>> thought it would be to run make dist, but it seems the real
>> release tarball is bootstrapped with autogen.sh, but NOT
>> configured, and make dist generates a tarball that is already
>> configured.
> 
> if you have autotools based build system than
> 
> make distcheck

Doesn't this do the same thing as make dist, only with a make check
and such thrown in?  So if you don't want to do the tests and just
generate the original tarball, make dist would do the trick right?
Yet it seems to leave files in the tarball that are NOT in the
official release.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSfPcSAAoJEJrBOlT6nu75nRkIAMwz+hVP4fswX4y+V3Xlu33I
avv8KO54Dq7UpOz6f52/PsFAimCNrqD8kM/1Ye2sLcmoWUGZriZooc8Rj2LZJiEu
XRqTf3m4tE9pFRNfgTy3ujGJILQfzOtWzCKpW8j54zK1ygfgBEu6bzFVLFQzIzH0
L3K45UTMss0x1QXWnBf9lRDtroeZk41Q5lZHmI24nRGb68Vck2EyZr2NdHukJldk
v/vUDBhTNgsbYk+Ihn49Ri2Y3IgnTjh0c9WlfOF7WR4jPTSQ0kWHLTau9qB37jch
XtXT8PTn8uSF4PPeQDJnR4XUekBwEZoiFoL8jDgoyM2erBYpC7iB7aAJoxfxhv8=
=vp2J
-----END PGP SIGNATURE-----
