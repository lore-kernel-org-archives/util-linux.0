Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:45370 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759478AbaEMM7r (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 13 May 2014 08:59:47 -0400
Message-ID: <5372173E.7090002@ubuntu.com>
Date: Tue, 13 May 2014 08:59:42 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Fwd: Bug#747948: mount: should warn user when potentially incorrect
 fstab order
References: <20140513100450.GA1083@europecamions-interactive.com>
In-Reply-To: <20140513100450.GA1083@europecamions-interactive.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uaOBWbFnQnafgmjVFF3gwaIkRnP5amCff"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uaOBWbFnQnafgmjVFF3gwaIkRnP5amCff
Content-Type: multipart/mixed;
 boundary="------------020907000804010903000806"

This is a multi-part message in MIME format.
--------------020907000804010903000806
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Forwarding this request from debian to get your thoughts.

--------------020907000804010903000806
Content-Type: message/rfc822;
 name="Bug#747948: mount: should warn user when potentially incorrect fstab order.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="Bug#747948: mount: should warn user when potentially incorre";
 filename*1="ct fstab order.eml"

Return-Path: <bounces+20140513-psusi=ubuntu.com@packages.qa.debian.org>
X-Original-To: psusi@localhost
Delivered-To: psusi@localhost
Received: from devserv.iradimed.com (localhost [127.0.0.1])
	by iriserv.iradimed.com (Postfix) with ESMTP id C980F57C92
	for <psusi@localhost>; Tue, 13 May 2014 06:10:05 -0400 (EDT)
Received: from cdptpa-cfl-vip.email.rr.com [107.14.166.56]
	by devserv.iradimed.com with POP3 (fetchmail-6.3.26)
	for <psusi@localhost> (single-drop); Tue, 13 May 2014 06:10:05 -0400 (EDT)
Received: from cdptpa-pub-iedge-vip.email.rr.com ([107.14.174.244])
          by cdptpa-fep12.email.rr.com
          (InterMail vM.8.04.01.13 201-2343-100-167-20131028) with ESMTP
          id <20140513100630.EOQ12811.cdptpa-fep12.email.rr.com@cdptpa-pub-iedge-vip.email.rr.com>
          for <psusi@cfl.rr.com>; Tue, 13 May 2014 10:06:30 +0000
Received: from [91.189.94.145] ([91.189.94.145:35174] helo=fiordland.canonical.com)
	by cdptpa-iedge05 (envelope-from <bounces+20140513-psusi=ubuntu.com@packages.qa.debian.org>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id 81/33-18538-4AEE1735; Tue, 13 May 2014 10:06:29 +0000
Received: from quantz.debian.org (quantz.debian.org [5.153.231.28])
	by fiordland.canonical.com (Postfix) with ESMTP id 789FBA180F2
	for <psusi@ubuntu.com>; Tue, 13 May 2014 10:06:28 +0000 (UTC)
Received: from qa by quantz.debian.org with local (Exim 4.80)
	(envelope-from <bounces+20140513-psusi=ubuntu.com@packages.qa.debian.org>)
	id 1Wk9bQ-0005s5-Dm
	for psusi@ubuntu.com; Tue, 13 May 2014 10:06:28 +0000
Received: from buxtehude.debian.org ([140.211.166.26])	from C=NA,ST=NA,
 L=Ankh Morpork,O=Debian SMTP,OU=Debian SMTP CA,CN=buxtehude.debian.org,
 EMAIL=hostmaster@buxtehude.debian.org (verified)	by quantz.debian.org with
 esmtps (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)	(Exim 4.80)	(envelope-from
 <debbugs@buxtehude.debian.org>)	id 1Wk9bP-0005p4-JX	for
 util-linux@packages.qa.debian.org; Tue, 13 May 2014 10:06:27 +0000
Received: from debbugs by buxtehude.debian.org with local (Exim 4.80)
 (envelope-from <debbugs@buxtehude.debian.org>)	id 1Wk9bN-0007FI-M7; Tue,
 13 May 2014 10:06:25 +0000
X-Loop: owner@bugs.debian.org
Subject: Bug#747948: mount: should warn user when potentially incorrect
 fstab order
Reply-To: David Guyot <david.guyot@europecamions-interactive.com>,
 747948@bugs.debian.org
Resent-From: David Guyot <david.guyot@europecamions-interactive.com>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-CC: LaMont Jones <lamont@debian.org>
X-Loop: owner@bugs.debian.org
Resent-Date: Tue, 13 May 2014 10:06:20 +0000
Resent-Message-ID: <handler.747948.B.139997551226595@bugs.debian.org>
X-Debian-PR-Message: report 747948
X-Debian-PR-Package: mount
X-Debian-PR-Keywords: 
X-Debian-PR-Source: util-linux
Received: via spool by submit@bugs.debian.org id=B.139997551226595 (code
 B); Tue, 13 May 2014 10:06:20 +0000
Received: (at submit) by bugs.debian.org; 13 May 2014 10:05:12 +0000
X-Spam-Checker-Version: SpamAssassin 3.3.2-bugs.debian.org_2005_01_02
	(2011-06-06) on buxtehude.debian.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=4.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FRT_SOMA2,HAS_PACKAGE,PGPSIGNATURE,RCVD_IN_DNSWL_LOW,
	SPF_PASS autolearn=ham version=3.3.2-bugs.debian.org_2005_01_02
X-Spam-Bayes: score:0.0000 Tokens: new, 56; hammy, 149; neutral, 228;
 spammy,	2. =?UTF-8?Q?spammytokens:0.993-1--sk:t=C3=A9l=C3=A9com,?=
 0.993-1--sk:tlcom	hammytokens:0.000-+--manpage, 0.000-+--H*u:1.5.21,
 0.000-+--H*UA:1.5.21,	0.000-+--H*u:2010-09-15, 0.000-+--H*UA:2010-09-15
Received: from mail-wg0-f49.google.com ([74.125.82.49])	by
 buxtehude.debian.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:128)	(Exim 4.80)
 (envelope-from <david.guyot@europecamions-interactive.com>)	id
 1Wk9aB-0006r8-Kw	for submit@bugs.debian.org; Tue, 13 May 2014 10:05:12
 +0000
Received: by mail-wg0-f49.google.com with SMTP id m15so122051wgh.8 for
 <submit@bugs.debian.org>; Tue, 13 May 2014 03:05:03 -0700 (PDT)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;       
 d=europecamions-interactive.com; s=google.europecamions-interactive.com;  
      h=date:from:to:subject:message-id:mime-version:content-type        
 :content-disposition:user-agent;        bh=/j21U1bRoIpdfo0u4nHFyphhIJnd1V7n2mpCnAOxASE=;
        b=k76CiSQM022xKvKZCddO1GzLriqa04sLjBt5We9iyRNxMgJzzouRaaKjHowTxd9RTF
         7Jc+uy0zQV4I1t9cIHFnE7Yr2u7dubIQCdVTB4hCq0dngsH83SFBlBuKevIBPSpcvaQf
         A12laLglft/GDvoBJ7gqn8hl0F+xR9bG4i/IU=
X-Google-Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;       
 d=1e100.net; s=20130820;        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;       
 bh=/j21U1bRoIpdfo0u4nHFyphhIJnd1V7n2mpCnAOxASE=;        b=O7ibBjHcyG7+tofvPJch3WtG6yhqv2PJWLJBQyiKHitjcyvNQLZV7SfbOPkAmm/D+Q
         LDAbVNNSfMeQ54eWoxCyDXuOp7AyLlhMn8yrI3i0h65ZT8gGNb3XZwXPF3UN8/JIQhJD
         8ZpTUDa0i2VlAvG2xxtezGpl0wbLYYGiZg+O8atfihYtj8YIEXjMc/2xGhDgi2V6bGTf
         1eSRfsGsP1lJS0RhBKbShqixQmASsgUIfQXQh/J1wx6BD1zjwPH7nydRw/sGcQ1fZLUp
         E9bpfR8HFnjFc4CjCHzCmn9Qh/PmxrhBFwigAq4Oksf29Q7TWWcSpS8NxWURqKmrsaAy
         XDvA==
X-GM-Message-State: ALoCoQnow+gr2kQ0azs9GeGHLXr2HDGgWk66EjmV1ZiM3hNmHdVr28JfGCIHabjvXV/fkgMAGTfo
X-Received: by 10.180.104.197 with SMTP id gg5mr19819002wib.2.1399975503383;
        Tue, 13 May 2014 03:05:03 -0700 (PDT)
Received: from localhost (45.199.72.37.dynamic.sat.abo.nordnet.fr.
 [37.72.199.45])        by mx.google.com with ESMTPSA id
 ed6sm21031876wib.20.2014.05.13.03.04.59        for
 <submit@bugs.debian.org>        (version=TLSv1.2 cipher=RC4-SHA
 bits=128/128);        Tue, 13 May 2014 03:05:01 -0700 (PDT)
Date: Tue, 13 May 2014 12:04:50 +0200
From: David Guyot <david.guyot@europecamions-interactive.com>
To: submit@bugs.debian.org
Message-ID: <20140513100450.GA1083@europecamions-interactive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Delivered-To: submit@bugs.debian.org
Delivered-To: util-linux@packages.qa.debian.org
Precedence: list
X-Loop: util-linux@packages.qa.debian.org
X-Debian: PTS
X-Debian-Package: util-linux
X-PTS-Package: util-linux
X-PTS-Keyword: bts
List-Unsubscribe: <mailto:pts@qa.debian.org?body=unsubscribe%20util-linux>
Resent-Sender: Debian QA <qa@quantz.debian.org>
X-RR-Connecting-IP: 107.14.168.105:25
X-Authority-Analysis: v=2.1 cv=IMiMC2fG c=1 sm=1 tr=0 a=gh04yOcj99DXDq3Wi4bM3A==:117 a=gh04yOcj99DXDq3Wi4bM3A==:17 a=ayC55rCoAAAA:8 a=LcaDllckn3IA:10 a=IYiE-y6vo-sA:10 a=d30dgbmnb6wA:10 a=wKyH-xRjJhUA:10 a=Ufg6un1qnmsA:10 a=wPDyFdB5xvgA:10 a=6U27iMW9AAAA:8 a=xNf9USuDAAAA:8 a=DfNHnWVPAAAA:8 a=1XWaLZrsAAAA:8 a=6tpA8nHtp_kOY8WuFNIA:9 a=wPNLvfGTeEIA:10 a=JnHH_aGRWMJ0Z0JWxHYA:9
X-Cloudmark-Score: 0


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Package: mount
Version: 2.20.1-5.3
Severity: wishlist

Hello, there.

Firstly, tl;dr: mount should warn when interlocked mountpoints in fstab
aren't in the expected order.

I recently noticed what at first seemed a bug in mount management of
fstab, but, according to the french mailing list users, it's more a lack
of warning.

Here is the problem: currently, at start, filesystems referenced in
fstab are mounted following their order in fstab. The problem is, when
/etc/fstab contains config for two filesystems with interlocked
mountpoints, in my case /var/www and /var/www/cache, they are not
necessarily in the right order. In my example, because of limitations in
my hosting provider installer and my drive configuration, /var/www/cache
configuration was stored before /var/www's one. Because man mount did
not contained any warning regarding mountpoints order, I assumed this
was automagically managed at start; of course, it proved me wrong, as
you can see in the following command dump taken after a reboot:

david@Curunir:~$ df -h
Sys. fich.    Taille Util. Dispo Uti% Mont=E9 sur
rootfs           54G  3,1G   49G   6% /
udev             10M     0   10M   0% /dev
tmpfs            13G  328K   13G   1% /run
/dev/md1         54G  3,1G   49G   6% /
tmpfs           5,0M     0  5,0M   0% /run/lock
tmpfs            35G     0   35G   0% /dev/shm
/dev/md3         20G  233M   19G   2% /var/log
/dev/md4        1,7T  852M  1,6T   1% /var/www/cache
/dev/md6         99G  188M   94G   1% /home
/dev/md7        1,7T  852M  1,6T   1% /var/www
tmpfs            32G     0   32G   0% /tmp
david@Curunir:~$ sudo su
[sudo] password for david:=20
root@Curunir:/home/david# umount /dev/md4
umount: /var/www/cache: not mounted
root@Curunir:/home/david# mount /dev/md4
root@Curunir:/home/david# df -h
Sys. fich.  Taille Util. Dispo Uti% Mont=E9 sur
rootfs         54G  3,1G   49G   6% /
udev           10M     0   10M   0% /dev
tmpfs          13G  328K   13G   1% /run
/dev/md1       54G  3,1G   49G   6% /
tmpfs         5,0M     0  5,0M   0% /run/lock
tmpfs          35G     0   35G   0% /dev/shm
/dev/md3       20G  233M   19G   2% /var/log
/dev/md4      124G  188M  118G   1% /var/www/cache
/dev/md6       99G  188M   94G   1% /home
/dev/md7      1,7T  852M  1,6T   1% /var/www
tmpfs          32G  4,0K   32G   1% /tmp
/dev/md4      124G  188M  118G   1% /var/www/cache

As you can see, in this case, the mounting of /var/www/cache behaves
erratically when its configuration is placed before /var/www's one in
/etc/fstab. When I noticed this problem, I checked all system logs, but
none showed messages regarding the mountpoints order, so I suspected a
failed disk, but my hosting provider's checks did not show any problem,
no more than fsck -f. I almost reinstalled the system, but, at the last
moment, I thought of fstab and changed mountpoints order to place
/var/www before /var/www/cache, and, after a reboot, the problem was
solved.

I mailed yesterday the Debian french users mailing list about this
problem, which I thought of as a bug, but they explained me that, under
some conditions, this behaviour may prove helpful. Nevertheless,
I still think that mount should warn about this most likely unwanted
behaviour, both in its manpage and by logging warnings in dmesg or syslog,
in order to help users confronted to this problem. At first, I expected
mount to reject such a mountpoint order to avoid problems, but, if I'm
right, it should be a bit extreme and bother users who uses this
behaviour to their advantage.

So, I would like to request the addition in mount of a warning when it
tries to mount a filesystem whose mountpoint contains an already used
mountpoint in order to avoid confusion for filesystem administation.
This warning should be printed on stderr, if not in dmesg and syslog, to
allow the admin to correct mountpoints order in the most likely case the
current behaviour is not the expected one.

Thanks for reading.

Regards.
--=20
David Guyot
Administrateur syst=E8me, r=E9seau et t=E9l=E9communications / Sysadmin
Europe Camions Interactive / Stockway
Moulin Collot
F-88500 Ambacourt
Tel: +33 (0)3 29 30 47 85
Fax : +33 (0)3 29 31 31 31

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTce5CAAoJEOdwVf06csTSOdMP/iXCJJjeGRUTmwlggsgiYv9j
UA9+JgMPOWuuJH0L/h523IPubNAFRfuYL2fx0+knbcUPcPZIwWO9J6ChTfQdsXSs
/GNtq+/5kZ5V6JLH5ujpIu5nX1KRMzkXk+VeqGzDYX7MD45rB5YLjKRh1xrtR51d
0Ti4lOY7Y1SSxjRhUUJkj8d76xtno9UB2sYxQdjNxIYbagL93tldv2OlW7stH6G6
bPgGiTg8aBFMMmFR1rmV6FBtF8BzG7OsDVYeSTJ5Sy+RllHhV4/XTiKhrQrn+wAs
1AnYhkUGYvzgDS85Tzl1UpokA87Ofmql0csQ8zJyPERui+LupRKLTY2tOS/5A5f7
io2lJUBmz+8uqTg7zBm6DxtcgYh6yV3arF9Eb41zxFrZ8S0F3UAHfLd+Vqxuh+pC
tZPv+QG9IADfG/KfhMxcrJ0abwauGBJA7aYfm1kiu9+WVcU+yroYEwYfn43HnAO1
h0q5iNzCVt1jHFtzMtMLsMWfesFTYN4YjZ7aWw6g4U3sHieh60ozk+fzRq0F7VOs
FDVdJGDX8SEbua/9mxgqFuOvtoCX9PETM9OLoonxluVhwYq4P3Z6zlW40Qe6Wc+t
cvcopV6ozgyYZo5bpglkg4pgz6YmMvoG1QPaan0f689cqh/6s25bw3v9zo7rksuC
bu5yf15EQZASGz5ebKlT
=sojb
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--


--------------020907000804010903000806--

--uaOBWbFnQnafgmjVFF3gwaIkRnP5amCff
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTchdBAAoJEI5FoCIzSKrwtn8H/jAFLAd03e4Lv6pHJOC/7Ylo
VSgAVSyG7Kz8B63Vj48LQkTsytZ54aL8bbJxI9Yb489690Fl9nuIAf5U6Ck6/qMn
kdN8cOrz0Abe53Uk7OWhbHyHqqLad5lWviEP15XiV/2AdUDZNiDLYypH9NLlwkQt
yYuIqGRcjxz4qpIflxUmucAkLTVg3T/zXDfLhbPbRMnEVQuk+HMdPxuPug3n3BK0
7iBTq+0PJWS/zeKBiUZY4OdY0J2QT1q4rtvuh5CldOM6m0WCAUTey7xBfoohErHc
T3ugVg/OmVKuO/i9ikj4Nql3gT5RSNXX+O4fR+oiytvPv1cZ+uj6VseSYnWZy2M=
=aRrN
-----END PGP SIGNATURE-----

--uaOBWbFnQnafgmjVFF3gwaIkRnP5amCff--
