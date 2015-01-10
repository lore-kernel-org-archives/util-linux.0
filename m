Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:52896 "EHLO
	Ishtar.hs.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872AbbAJA3X (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 9 Jan 2015 19:29:23 -0500
Message-ID: <54B0725A.2030704@tlinx.org>
Date: Fri, 09 Jan 2015 16:29:14 -0800
From: Linda Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: Phillip Susi <psusi@ubuntu.com>
CC: util-linux@vger.kernel.org
Subject: Re: fdisk units size & disk manufacturers buying the standard
References: <CAF+0mvmE_i0P350hT4E4a-ZTTuuS5PdZ2vw1siQ2HowpB2Xn-g@mail.gmail.com>	<20141204130044.GH1994@x2.net.home> <CAF+0mvm-fGvf3BOL6f8SsJgp75a3CP1xsVwkdD+_zP4hg06npQ@mail.gmail.com> <548619AF.5070900@tlinx.org> <54AB0D8F.2010100@ubuntu.com> <54ADCD95.4010903@tlinx.org> <54AE0005.9070502@ubuntu.com> <54AF3ED8.2030508@tlinx.org> <54AFECE2.1050407@ubuntu.com>
In-Reply-To: <54AFECE2.1050407@ubuntu.com>
Content-Type: multipart/mixed;
 boundary="------------030500000807090407040102"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.
--------------030500000807090407040102
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Phillip Susi wrote:
> Umm... yea.. you said bytes are not SI, I'm saying watt-hours aren't
> either.  You said that means the kilo prefix should be base 2 since a
> byte is 2^3 bits.  I'm saying by the same silly logic, a
> killowatt-hour should be 3600 watt-hours since a watt-hour is 60^2
> joules.  Are you getting it now?
>   
====
    I was hoping you'd ask that.
    The 'kilo' applies to the 'watt', not the hour.  If you had
1000 kWHr, you wouldn't see normal usage calling it 1 MWHr.  It's ok
to use Metric prefixes with metric units. Multiplying a metric
quantity by a non-metric value doesn't change that -- but you
won't see power plants rated that way, nor will you see
that on your power bill.

    You will see articles talking about hard disk technologies speaking
of density in 'bits'/area (where either bit OR area can have an SI
quantity), since a bit requires no conversion constant to go from
flux-changes/area. HD-densities (in the US) are expressed in
<metric-prefix>-bits/in².  Again, with the metric prefix applying to
the unit that requires no conversion constant (the bit) to be expressed
as some combination of SI units.

    This is a great point here -- concerning the HD industry.
If they were so concerned about using the metric system, why wouldn't
they specify density in <prfx>-bits/cm².  Snort.
 

>   
>> See kernel messages for a 10b-T ethernet.
>>
>> [   21.224641] ixgbe 0000:05:00.0: PCI Express bandwidth of 32GT/s 
>> available [   21.224644] ixgbe 0000:05:00.0: (Speed:5.0GT/s, Width:
>> x8, Encoding Loss:20%)
>>     
>
> That message is referring to the encoding loss on the pci express gen
> 2 bus, not ethernet.
>   
---
    Thank you.  I didn't know that.  Now I know I need a HW upgrade... ;-)


>   
>> excludes optional protocols.  The 125MB/s is a max theoretical rate
>> and is in base 2.
>>     
>
> No, as I said, that is base 10, not base 2.  1,000,000,000 bps / 8
> bits per byte = 125,000,000 bytes / second, not 131,072,000 bytes.
>   
---
    My bad... you're right.  I *thought* it was the other way
around at one point, but later realized that the output of 'dd'
was in decimal prefixes (regardless of user input).  My test
script even tries to convert units back to base2... ;-)
>   
>> In practice, 125 millionBytes for writes and 119 millionBytes are
>> a benchmark maximum that includes headers (SMB/CIFS for the test I
>> most frequently run).
>>     
>
> Nope, not possible.
>   
===
    Maybe not, but it is repeatable by myself and other people.
Do you have samba and a 1Gb connection?  It's fairly easy to setup.
I'll even attach the primitive test script (bash) -- easy to use
once you get the files setup in a server-dir. 

I'm on an internal network (so no encryption on the link).  Client
is Win7SP1, linux flavor = opensuse, but kernel is vanilla,
currently at 3.17.3. 
Measuring line speeds only, I use the following files in my home
directory on the server:

>  cd
>  ll zero null
crwxrw-rw- 1 1, 3 Jan  9 13:55 null
crwxrw-rw- 1 1, 5 May  7  2013 zero
---
Using cygwin 'dd', for client writes I read from /dev/zero and write
to 'null' oflag=direct conv=notrunc,nocreat, BS=16M, total size=4GB
for client reads: if=zero of=/dev/null.

Note -- if you make them regular files, at least defrag them.
Using 'xfs', you can use "xfs_fsr" to make a file contiguous.

Other people on the samba list report similar results, though
it is definitely a minority who have tuned their systems for that.
Besides what I can do on windows, I have also used a fair number
of large or insane parameters on the linux networking stack.

Maybe it's your hardware?  For my fastest results, I've been using
Intel dual-port cards:

Intel Corporation 82571EB Gigabit Ethernet Controller (rev 06)
Intel Corporation Ethernet Controller 10 Gigabit X540-AT2 (rev 01)

Identical cards on server and client -- though my client only uses the
10Gb card now...(300-650MB/s transfer tops... varies widely).

I also use 9kB (9000) byte packets and whatever offload features I
find yield a positive effect.  You aren't going to get those speeds
out of the box... it does take a bit of performance tuning.

>   
>> I.e. 125millionBytes/s -- the base10 number IS a benchmark maximum 
>> that includes protocol headers (specifically for SMB).
>>     
>
> Nope.
>   
---
I've seen it multiple times -- others have reproduced it.
Vs. the max ranges for 10Gb (8Gb on my setup), have been in the
600's (usually lower) (smb protocol is cpu bound and usually w/1 user
connection -- though newer smb (win8+) seems to have some beginnings
for support for using parallelism in the processors.
>   
>> But their core unit 'bit' like the 'second', is based on a minimal
>> distinct magnetic flux variation on the media.  It is directly
>> usable with SI prefixes.
>>     
>
> No, it isn't.
Reality disagrees: See:

   http://en.wikipedia.org/wiki/Bit_cell
   http://www.softpres.org/?id=glossary:bit_cell

  Specifically: (quote)

This is essentially the distance along the track allocated for the 
recording of an area of Flux. That is, in each “cell” there are magnetic 
particles that together indicate a detectable magnetic polarity of set 
length. Note that bit cells are not read as bits of data directly, they 
are used to form the flux transitions used to make up the Encoding. 
Every bit cell contains either a change of polarity (1) or not (0).

--endquote--

Perhaps you have some references that would convince me that the
above terminology isn't both common and standard in this field?


Only when you get into marketing speak (getting away from tech speak),
will you see things like $$$/[MGT]B, where the prefix applies
to 'Byte'.  But again, that's marketing speak.

Disk manufacturers describe and talk about "bits"/area when describing
disk technologies.


>   
>> You can't get the correct number of bytes transfered over 1 300bps
>> modem by dividing by 8.
>>     
>
> Umm, yes, that is exactly what you do.  It kind of follows from the
> definition of bits and bytes.  Of course, there weren't 1,300 bps
> modems, but still.
>   
---
    That's "one" 300bps modem.  And no, you don't divide by 8
since 300bps modems only had a 30cps throughput -- not 37.5 as you
would seem to indicate.


>   


--------------030500000807090407040102
Content-Type: text/plain;
 name="iotest"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="iotest"

IyEvYmluL2Jhc2ggLXUKIyBpb3Rlc3QgdjAuMSAtIGxhd2Fsc2g6IG9wZW4gdXNhZ2UgYWxs
b3dlZAoKX3ByZ3B0aD0iJHswOj99IjsgX3ByZz0iJHtfcHJncHRoIyMqL30iOyBfcHJnZHI9
IiR7X3ByZ3B0aCUvJF9wcmd9IgpbWyAteiAkX3ByZ2RyIHx8ICRfcHJnID09ICRfcHJnZHIg
XV0gJiYgJF9wcmdkcj0iJFBXRCIKZXhwb3J0IFBBVEg9IiRfcHJnZHI6JF9wcmdkci9saWI6
JFBBVEgiCnNob3B0IC1zIGV4cGFuZF9hbGlhc2VzIGV4dGdsb2Igc291cmNlcGF0aCA7IHNl
dCAtbyBwaXBlZmFpbAoKI2luY2x1ZGUgc3RkYWxpYXMKCkRkPSQodHlwZSAtUCBkZCkKCltb
ICREZCBdXSB8fCB7IGVjaG8gIkNhbm5vdCBmaW5kIGRkLiAgQ2Fubm90IHByb2NlZWQuIjsg
IGV4aXQgMTsgfQoKYWxpYXMgaW50Q29uc3Q9ZGVjbGFyZVwgLWl4IGludD1kZWNsYXJlXCAt
aSBteT1kZWNsYXJlCmFsaWFzIHN0cmluZz1kZWNsYXJlIHN1Yj1mdW5jdGlvbiBhcnJheT1k
ZWNsYXJlXCAtYQojIDEgbnVtID0gYmxvY2sgc2l6ZQojIG51bS1udW0gPSByYW5nZSBvZiBi
bG9jayBzaXplcyB0byB0ZXN0OyB3L2luY3JlbWVudCA9ICIyeCIsIHNvCiMgNE0tMTZNIHRl
c3RzIDRNLCA4TSwgMTZNCiMgNE0tMTJNIHRlc3QgNE0sIDhNLCAxMk0KIyBjb3VudCBhZGp1
c3RlZCB0byB4ZmVyIDRHLCByb3VuZGluZyB1cAojLS0tLQoKI2FsbCB4ZmVycyBhcmUgdXNp
bmcgJ2RldmljZXMnICgvZGV2L3plcm8gZm9yIHNvdXJjZSwgL2Rldi9udWxsIGZvciB0YXJn
ZXQpCiMgcmVtb3RlIGZpbGVuYW1lcyAiemVybyIgYW5kICJudWxsIiBzaG91bGQgYmUgc2V0
dXAgdG8gYmUgcmVtb3RlIGRldmljZXMKCmludENvbnN0IEs9MTAyNAppbnRDb25zdCBNPSRb
SypLXQppbnRDb25zdCBHPSRbTSpLXQppbnRDb25zdCBUPSRbRypLXQoKaW50IEJTPSRbMTYq
TV0KaW50IGNvdW50PTI1NgppbnQgSU9TSVpFPSR7SU9TSVpFOi00Kkd9CgojCQlkZXN1ZmZp
eCAJMXN0IGFyZyA9IG51bStzdWZmaXggLT4gY29udmVydCB0byBpbnQKIwkJCQkJCQkybmQg
YXJnID0gb3B0aW9uYWwgYnVmZiBuYW1lIChlbHNlIHByaW50IHRvIHN0ZG91dCkKIwkJCQkJ
CQlyZXR1cm4gMCBpZiBubyBlcnJvcgoKc3ViIGRlc3VmZml4IHsJCQkJCQkjY29udmVydCBu
dW0rU3VmZiA9PiBpbnQgc3RvcmUgaW4gb3B0aW9uYWwgQnVmZgoJc3RyaW5nIHN0cj0iJHsx
Oj99IiA7IHNoaWZ0CglzdHJpbmcgYnVmbmFtPSIiOyAoKCQjKSkgJiYgYnVmbmFtPSQxCglp
ZiBbWyAkcCA9fiBeKFswLTldKykoW0tNR1RdKSQgXV07IHRoZW4gCgkJaW50IG51bT0ke0JB
U0hfUkVNQVRDSFsxXX0qJHtCQVNIX1JFTUFUQ0hbMl19CgkJKChudW0pKSB8fCByZXR1cm4g
MQoJCWlmIFtbICRidWZuYW0gXV0gOyB0aGVuIHByaW50ZiAtdiAkYnVmbmFtICIlZCIgIiRu
dW0iCgkJZWxzZSBwcmludGYgIiVkIiAiJG51bSIgOyBmaQoJZWxzZSAKCQlyZXR1cm4gMQoJ
ZmkKfQoKCgoKc3ViIGhkaXNwIHsKCWludCBudW09JHsxOj99OyBzaGlmdAoJc3RyaW5nIGJ1
Zm5hbT0iIjsgKCgkIykpICYmIGJ1Zm5hbT0kMQoJc3RyaW5nIHN1Zj0iIgoJaW50IGFucz1u
dW0KCWFycmF5IHBvd3M9KCdLJyAnTScgJ0cnICdUJykKCWZvciBzIGluICR7cG93c1tAXX07
ZG8KCQlpbnQgc2k9JHMKCQlpZiAoKChudW0vc2kpKnNpPT1udW0pKTsgdGhlbgoJCQlhbnM9
bnVtL3NpO3N1Zj0iJHMiCgkJZmkKCWRvbmUKfQoKc3ViIGNoZWNrX3BhcmFtcyB7CglpbnQg
bnVtPTAKCWlmICgoJCMpKSA7IHRoZW4gCgkJc3RyaW5nIHA9IiQxIjsgc2hpZnQ7CgkJaWYg
W1sgJHAgPX4gKFswLTldKykoW0tNR1RdKSBdXTsgdGhlbiAKCQkJbnVtPSR7QkFTSF9SRU1B
VENIWzFdfSoke0JBU0hfUkVNQVRDSFsyXX0KCQlmaQoJZmkKCSgobnVtKSkgJiYgewoJCUJT
PW51bQoJCWNvdW50PUlPU0laRS9CUwoJfQp9CgooKCQjKSkgJiYgY2hlY2tfcGFyYW1zICIk
QCIKCmFycmF5IHJlYWRhPSgvaC96ZXJvIC9kZXYvbnVsbCkKYXJyYXkgd3JpdGVhPSgvZGV2
L3plcm8gL2gvbnVsbCBjb252PW5vY3JlYXQsbm90cnVuYykKCnN1YiBkZF9uZWVkX2lvICB7
Cglsb2NhbCBpZj0iJDEiIG9mPSIkMiI7IHNoaWZ0IDIKCW5pY2UgLS0xOSAkRGQgaWY9IiRp
ZiIgb2Y9IiRvZiIgYnM9IiRCUyIgY291bnQ9IiRjb3VudCJcCgkgCQlvZmxhZz1kaXJlY3Qg
aWZsYWc9ZGlyZWN0IGNvbnY9bm9jcmVhdCAiJEAiCn0KCnN1YiBkZCB7Cglsb2NhbCBpZj0i
JDEiIG9mPSIkMiIgO3NoaWZ0IDIKCSNlY2hvICRkZCBpZj0iJGlmIiBvZj0iJG9mIiBicz0i
JEJTIiBjb3VudD0iJGNvdW50IiAiJEAiID4mMgoJYXJyYXkgb3V0IGVycgoJcmVhZGFycmF5
IGVyciA8IDwoIFwKCQlyZWFkYXJyYXkgb3V0IDwgPChkZF9uZWVkX2lvICIkaWYiICIkb2Yi
ICIkQCI7aW50IHM9JD87IAoJCQkJCQkJCQkJCSgocykpICYmIGVjaG8gInN0YXQ6JHMiPiYy
ICApIDI+JjEgKQoJIwoJaWYgKCgkeyNlcnJbQF19KSkgO3RoZW4gZWNobyAiJHtlcnJbQF19
IjsgZXhpdCAxOyBmaQoJcmV0dXJuIDAKfQoJCmZ1bmN0aW9uIGRkX2Zvcm1hdCB7IG15IGxu
Cgl3aGlsZSByZWFkIGxuO2RvCgkJZWNobyAkbG4gfCB3aGlsZSByZWFkIGJ5dGVzIGJ0eHQg
cG51bSBzdWZmcCBcCgkJCQkJCQkJCQkJY29wdCB0aW1lIHVuaXRjIHJhdGUgcmFfdW5pdDsg
ZG8KCQkJW1sgJGJ5dGVzID09IHJlY29yZHMgXV0gJiYgY29udGludWUKCQkJW1sgJHtwbnVt
OjA6MX0gIT0gXCggfHwgJHtzdWZmcDowLTE6MX0gIT0gXCkgXV0gJiYgY29udGludWUKCQkJ
bnVtPSIke3BudW06MX0iIAoJCQlzdWZmPSIke3N1ZmZwJT99IiAKCQkJdW5pdD0iJHt1bml0
YyU/fSIKCQkJcHJpbnRmICIlczolczolczolczolczolczpcbiIJIiRudW0iICIkc3VmZiIg
IiR0aW1lIiAiJHVuaXQiICIkcmF0ZSIgIiRyYV91bml0IgoJCWRvbmUKCWRvbmUKfQoKc3Vi
IG9uZWN5Y2xlIHsKCWVjaG8gLW4gIlI6IjsgeyBkZCAiJHtyZWFkYVtAXX0ifHwgZXhpdCAk
PzsgfSB8IGRkX2Zvcm1hdCAKCWVjaG8gLW4gIlc6IjsJeyBkZCAiJHt3cml0ZWFbQF19IiB8
fCBleGl0ICQ/OyB9IHwgZGRfZm9ybWF0IAp9CgpvbmVjeWNsZQo=
--------------030500000807090407040102--
