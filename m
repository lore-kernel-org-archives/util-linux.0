Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:63021 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab3J3P7p (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 30 Oct 2013 11:59:45 -0400
Message-ID: <52712CF0.9070603@ubuntu.com>
Date: Wed, 30 Oct 2013 11:59:44 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Bernhard Voelker <mail@bernhard-voelker.de>
CC: util-linux@vger.kernel.org
Subject: Re: Bind mounts record fstype of none
References: <527122AF.90003@ubuntu.com> <1530541679.232932.1383147597747.open-xchange@email.1und1.de>
In-Reply-To: <1530541679.232932.1383147597747.open-xchange@email.1und1.de>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/30/2013 11:39 AM, Bernhard Voelker wrote:
> yes, df(1) is from coreutils. ;-)
> 
> However, latest df(1) will skip such bind mounts per default - but 
> now because of some 'bind' information (which is not available 
> anyway), but just because it skips "duplicates" based on the
> device numbers. For the same device number, it will output that
> with the shortest mount point name. You have to use -a to see all.

So is mount wrong for recording the filesystem type as 'none' or not?


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJScSzwAAoJEJrBOlT6nu7587EH/j35wWxXuNqljBAn9B4fimyd
UcTuchJuPoeWg6fmB6XGJB+Zuv/sari8ur/ihVuV+SiC9+MvBYrkoy+xlTW+vmMc
B4usMZRvZQK9QW74nvqibDgp2S1mG2iEbpO58oJK2E6ILQoFLNPY2Awuz2VR7LY9
sLxseN4eSzRdPFRiFfzFIaI6s6PO4fvcJceNukO2LIvbhKEhufduTPEJrPKMDIYK
OAgmsDm5PUDCITDyyO9YYlZdVm/RxJmRvssdN+WycfsXzYgad+/BAdc0WENtw81R
JHg7MciHqNfNBJ5bmlqwnnynud37gWe7dYRLNoMgXDcAMsIwjBL1NsrEpKcmqmk=
=05sY
-----END PGP SIGNATURE-----
