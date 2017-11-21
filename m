Return-Path: kalle@projektwerkstatt.de
Subject: Re: mount: how to identify filesystems to mount them
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <ff28d2dd-c527-3d5f-e804-1ce468518b83@projektwerkstatt.de>
 <20171115163729.ihe4vnhmxbj2jprz@ws.net.home>
 <cdc6aeb0-7263-e80a-1f3c-87521de7fca9@projektwerkstatt.de>
 <20171116104120.a4clmwg5uu4lbkps@ws.net.home>
From: kalle <kalle@projektwerkstatt.de>
Message-ID: <7c6384ce-3d74-de64-22ab-77339787067c@projektwerkstatt.de>
Date: Tue, 21 Nov 2017 23:35:39 +0100
MIME-Version: 1.0
In-Reply-To: <20171116104120.a4clmwg5uu4lbkps@ws.net.home>
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>

hello,
here I have some further points related to mount-manpage:
-it would be good to make a reference to lsblk(8)
-the mentioning that mounting often requires privileges should come at
the beginning of the "Description"-section and not so late as in the
section "non-superuser mounts". It would also make sense to explain how
the mount commands requests privileges and maybe also why, since for the
"how",often every user can execute it while the device can be accessed
when the effective user-id is set to root through mount (with setuid)
[this is how it behaves in my system].. In the latter section it says
furthermore: "Normally,only the superuser can mount filesystems". Since
in al lot of OSes with X, devices as USBs are mounted automatically when
plugged in, this `normally' isn't on the ground of reality anymore.
Maybe make some short notice on this. I in the beginning wondered why
GNU/Linux makes mounting on the console so difficult and I still don't
know it ( I speculate it's about  security reasons, which are dropped
for X-users mostly.
-maybe some short explanation, why the filesystem should be specified
via "-t" while mounting, since mounting itselfs seems also to work
without this
-proposal: when writing about `proc', write `proc(5)'
-since it normally seems to be necessary that the same user can only
unmount a device, who mounted it, it would make sense to mention how
users can recognize the mounting user.
-sentence "so  the  use  symlinks": put an "of" before "symlinks"
- "are documented […] in the kernel source tree": I don't know where or
what this is..
Now, after looking around a bit, I assume you mean
/usr/src/linux-headers-SOMEVERSION/, but without finding the file
`sharedsubtree.txt' in the file Documentation/filesystems.


Am 16.11.2017 um 11:41 schrieb Karel Zak:
> On Wed, Nov 15, 2017 at 11:58:44PM +0100, kalle wrote:
>> On 15.11.2017 17:37, Karel Zak wrote:
>>> On Wed, Nov 15, 2017 at 05:18:17PM +0100, kalle wrote:
>>>> hello,
>>>> -i think it would be good, if it would be explained shortly, what a file
>>>> system is
>>>> -what would be good would be an explanation, how to find out filesystem,
>>>> label, UUID or device name of a given device...
>>> man mount, section "Indicating the device" is not enough?
>> No. given the case I have a usb-stick. If I would recognize the label, the
>> files on it or the size because they are written outside on the hardware of
>> the stick or because I recognize my files stored on the stick. Now if I plug
>> it in, how do I know which device to mount? "mount -L" doesn't help me
>> further, since I don't know the label exactly by heart, pressing the
>> `TAB'-key produces file names and not labels.
>> What I did in the past was looking at /dev/disk/by-... for the label/id to
>> recognize my stick, but this procedure is lengthy and not recommended by you
>> on the man-page.
>> I simply don't have a nice answer to this problem.
> 
> OK, I've updated the man page. The command "lsblk --fs" should be goot
> enough to provide overview about available filesytems and its
> LABEL/UUIDS.

Where do I find the actual version?
> 
>     Karel
> 

kalle
