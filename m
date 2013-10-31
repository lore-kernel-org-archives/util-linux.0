Return-Path: psusi@ubuntu.com
Message-ID: <527266B0.7040201@ubuntu.com>
Date: Thu, 31 Oct 2013 10:18:24 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: Bind mounts record fstype of none
References: <527122AF.90003@ubuntu.com> <20131031105747.GB1536@x2.net.home>
In-Reply-To: <20131031105747.GB1536@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/31/2013 6:57 AM, Karel Zak wrote:
> On Wed, Oct 30, 2013 at 11:15:59AM -0400, Phillip Susi wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> I came across an old bug filed in debian noting that mount
>> records the fstype for bind mounts as 'none' and this causes df
>> to suppress
> 
> It was explicitly requested by Al Viro to use "none" for some VFS
> operations years ago (c4966ccb16868fa748009a826340fac9d1b1ce39, 
> 0fae284a7a13d4d2dba7a908e0662a6d9c46f877).
> 
> I think it's correct, because FS type does not make any sense
> there and it's waste of time to try to determine FS type for
> MS_BINS or MS_PROPAGATION operations.

How does it not make sense?

>> showing it.  This seems like an error to me.  The type should be
>> what the actual filesystem type is, and if df wants to suppress
>> showing bind mounts, it should do so based on the bind flag.
> 
> Seems like you're victim of the mtab file. My Fedora 19:
> 
> # mount --bind /home /mnt/test # mount | grep /mnt/test /dev/sda5
> on /mnt/test type ext4 (rw,relatime,data=ordered)

Since the kernel reports the correct type, then I'd say mount should
behave the same when using mtab, and record it right instead of
forcing it to none.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJScmawAAoJEJrBOlT6nu75B6cIAMHuRn7YaD6ZO2oS0e68RlyO
FGBNVkiUezG/cw8GBxihiSejlZP99cR0VMeD7ImLjLpuKbJ/tOdqHUGIFneDZu6I
hBz7luqVTnyOiimEaX8AXMWy4LOZzXiFd/etWTG9QpePsj+e+NRGj826cXmEpYoX
uIuWze+IRZc7NLzb+TmTtJcv/2a6yFZHxIdTt9SYzsPWWJ23m+t9GWtTbMt4CnXZ
04BxJpryA04KoZhJBeliHu87xQ5cQBOfZkBavx2rpoGoiQRez9XVorif3hP7SBwT
KD370LQr0GWbTQo1YEuIHXGaAcqEW/yQcPWKmekJXkg+1dhgE5c8Rvly37jeKRs=
=+osw
-----END PGP SIGNATURE-----
