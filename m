Return-Path: yigal@plexistor.com
MIME-Version: 1.0
From: Yigal Korman <yigal@plexistor.com>
Date: Tue, 21 Jun 2016 16:59:39 +0300
Message-ID: <CACTTzNa3aTiCrHBQrvwVvFwLQpTdGTDLGt+G3wycpMXEzXbXcw@mail.gmail.com>
Subject: blkid partition infomartion
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a1142c1ae86b2530535ca3c75
List-ID: <util-linux.vger.kernel.org>

--001a1142c1ae86b2530535ca3c75
Content-Type: text/plain; charset=UTF-8

Hi Karel,
I have a question regarding this patch in util-linux:
"blkid: don't ignore info about partitions on non-formated devices"
(commit f8098e2b2c0a8a98ccb603f53dfba0cc05683a39)

I wanted to know what was the trigger for this change? what's the reasoning
behind it?

Background:
I have an Linux automation script that formats a given partition and mounts
it.
In order to verify that the partition is empty (ie no other data exists
there) I've been using 'blkid -p <partition>;  [[ $? != 2 ]] && fail".
Which stopped working correctly when I moved to Ubuntu 16.04.
I've tracked the issue to the patch mentioned above.

To me this patch seems to counter blkid behavior - returning the partition
information when the given device is the partition doesn't describe what
the device contains.
The same way that if /dev/sda is part of LVM, then 'blkid -p /dev/sda' will
return the LVM information, but doing 'blkid -p /dev/mapper/vg-lv' will
return what's inside the logical volume and not the logical volume
information (and nothing if the empty).

Do you have a suggestion for a different method for testing if a device is
empty?

Regards,
Yigal

--001a1142c1ae86b2530535ca3c75
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Karel,<div>I have a question regarding this patch in ut=
il-linux:</div><div>&quot;blkid: don&#39;t ignore info about partitions on =
non-formated devices&quot;</div><div><div>(commit f8098e2b2c0a8a98ccb603f53=
dfba0cc05683a39)</div></div><div><br></div><div>I wanted to know what was t=
he trigger for this change? what&#39;s the reasoning behind it?<br></div><d=
iv><br></div><div>Background:</div><div>I have an Linux automation script t=
hat formats a given partition and mounts it.</div><div>In order to verify t=
hat the partition is empty (ie no other data exists there) I&#39;ve been us=
ing &#39;blkid -p &lt;partition&gt;;=C2=A0=C2=A0[[ $? !=3D 2 ]] &amp;&amp; =
fail&quot;.<br></div><div>Which stopped working correctly when I moved to U=
buntu 16.04.</div><div>I&#39;ve tracked the issue to the patch mentioned ab=
ove.</div><div><br></div><div>To me this patch seems to counter blkid behav=
ior - returning the partition information when the given device is the part=
ition doesn&#39;t describe what the device contains.</div><div>The same way=
 that if /dev/sda is part of LVM, then &#39;blkid -p /dev/sda&#39; will ret=
urn the LVM information, but doing &#39;blkid -p /dev/mapper/vg-lv&#39; wil=
l return what&#39;s inside the logical volume and not the logical volume in=
formation (and nothing if the empty).</div><div><br></div><div>Do you have =
a suggestion for a different method for testing if a device is empty?</div>=
<div><br></div><div>Regards,</div><div>Yigal</div></div>

--001a1142c1ae86b2530535ca3c75--
