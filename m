Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:54624 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178AbaBOECq (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Fri, 14 Feb 2014 23:02:46 -0500
Message-ID: <52FEE6E5.7010206@ubuntu.com>
Date: Fri, 14 Feb 2014 23:02:45 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Bruce Dubbs <bruce.dubbs@gmail.com>, util-linux-ng@vger.kernel.org
Subject: Re: findmnt/df discrepancy
References: <52FB9355.3090702@gmail.com> <20140212153806.GB583@rampage>
In-Reply-To: <20140212153806.GB583@rampage>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 02/12/2014 10:38 AM, Dave Reisner wrote:
> It's the reserved space on the filesystem. On an ext4 FS where the 
> reserved space is 0%, df and findmnt (mostly) agree:

Why would findmnt report a different value?  It is the kernel that
adjusts the numbers it returns in statfs(), which both should be using.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCgAGBQJS/ublAAoJEI5FoCIzSKrwhYwH/RQeM8f0vTACy6bRGzCtFyPy
YJL4/GAJk2B4tTPGqcAUFaByu5XR760unjMvk6TRUjgvPtJN35oaF0SwYqA68o7Q
GviH5+21hztANKQz/JO6RZPbzueEttSlCsAjNbhuFmY/+ysMkxGA9inlNyE14MU0
pGOfTtpw0vAAJFX0+7gjGZZkOsm8yYH4yhb0ERoQACYZxrcFLRaqxV+V3eKhtZuo
tFvP2mNXCPk4AyP9oXaepPESBaZmmPNh81FvZBAarZURKefPJDw5TJslZmeLAO1O
fWUmEa+xBexX7jSwqgdeIYk0Inci+X2kTx5dckkQM9LcnVqJ67nYufb+IDzQoow=
=USil
-----END PGP SIGNATURE-----
