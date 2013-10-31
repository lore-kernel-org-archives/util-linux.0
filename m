Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:49840 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536Ab3JaP27 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 31 Oct 2013 11:28:59 -0400
Message-ID: <52727739.70301@ubuntu.com>
Date: Thu, 31 Oct 2013 11:28:57 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: Bind mounts record fstype of none
References: <527122AF.90003@ubuntu.com> <20131031105747.GB1536@x2.net.home> <527266B0.7040201@ubuntu.com> <20131031151001.GH1536@x2.net.home>
In-Reply-To: <20131031151001.GH1536@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/31/2013 11:10 AM, Karel Zak wrote:
> There is *many disadvantages* when you use mtab, not sure if it
> make sense to fix the issues especially when mtab is currently
> unused by (almost) all distributions.
> 
> Maybe we can keep the fstype and not replace it with "none" for
> mtab, but is it so important when we use "none" since 2009 and mtab
> is almost dead?

I know there were a number of issues with this transition, have they
all been worked out at this point?  Is all you need to do to make the
switch is replace /etc/mtab with a symlink to /proc/mounts?  Maybe
I'll try doing that.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJScnc5AAoJEJrBOlT6nu75HBEH/i7nKpCaq7TkgArB0IgnmSqM
fHkp1jMIltOxkfVDj8ma6hErYUJ+2g4abgKF8nrP39NWiFldrCBqTjOAr2kOl9wn
jO40x9ur6SJQpVbSrmtHOam05J+P09N2SRXb/LAVIsUzTyIvw3kBFaGpl0ElJz8Q
Jf3yTWr5gPyR14oAdOKdzkW70rktob2lRGM4DetChQd8H0LtfiaODtaBSbDyJMQ7
P8ErR42Isosf2+RBW+c/EC3biE82QsMcJjMP4eJ+A3uG8ZMlOTtDpthvMjQPY6+0
xCBz9Qd9yjvfgGTxnuV+AyX9Xa+mQNdS4/MtvyCwTF3TTKekhkYMK2CMSJ9gSdI=
=OpPE
-----END PGP SIGNATURE-----
