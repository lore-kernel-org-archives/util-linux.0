Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: "George Spelvin" <linux@horizon.com>
Subject: Re: e2fsck: /dev/hda2 is mounted.
Date: Tue, 15 Mar 2016 00:38:10 +0100
Cc: kzak@redhat.com, util-linux@vger.kernel.org
References: <20160314184419.7527.qmail@ns.horizon.com>
In-Reply-To: <20160314184419.7527.qmail@ns.horizon.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201603150038.11408.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Monday 14 March 2016, George Spelvin wrote:
> Thanks for the help.  I don't quite understand the structure of
> libmount well enough to know where a fix *should* go.
>
> > Can you send me your /proc/self/mountinfo? (or at least root fs
> > entry from the file)

> 12 0 3:2 / / rw,relatime - ext4 /dev/root
> [...]

Maybe it's not related but I've noticed a similar issue where 
getmntent() was not able to parse long lines in /proc/mounts. It was 
with musl and I've asked there
http://permalink.gmane.org/gmane.linux.lib.musl.general/9548

I've got no reply, so maybe it was a stupid question and we are doing 
something wrong ;)

cu,
Rudi
