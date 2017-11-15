Return-Path: kalle@projektwerkstatt.de
Subject: Re: mount: how to identify filesystems to mount them
To: Karel Zak <kzak@redhat.com>
References: <ff28d2dd-c527-3d5f-e804-1ce468518b83@projektwerkstatt.de>
 <20171115163729.ihe4vnhmxbj2jprz@ws.net.home>
Cc: util-linux@vger.kernel.org
From: kalle <kalle@projektwerkstatt.de>
Message-ID: <cdc6aeb0-7263-e80a-1f3c-87521de7fca9@projektwerkstatt.de>
Date: Wed, 15 Nov 2017 23:58:44 +0100
MIME-Version: 1.0
In-Reply-To: <20171115163729.ihe4vnhmxbj2jprz@ws.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <util-linux.vger.kernel.org>

On 15.11.2017 17:37, Karel Zak wrote:
> On Wed, Nov 15, 2017 at 05:18:17PM +0100, kalle wrote:
>> hello,
>> -i think it would be good, if it would be explained shortly, what a file
>> system is
>> -what would be good would be an explanation, how to find out filesystem,
>> label, UUID or device name of a given device...
> man mount, section "Indicating the device" is not enough?
No. given the case I have a usb-stick. If I would recognize the label, 
the files on it or the size because they are written outside on the 
hardware of the stick or because I recognize my files stored on the 
stick. Now if I plug it in, how do I know which device to mount? "mount 
-L" doesn't help me further, since I don't know the label exactly by 
heart, pressing the `TAB'-key produces file names and not labels.
What I did in the past was looking at /dev/disk/by-... for the label/id 
to recognize my stick, but this procedure is lengthy and not recommended 
by you on the man-page.
I simply don't have a nice answer to this problem.
> OK, I think, we can add some short note about "what filesystem is" to the
> begin of the mount man page for people who accidentally booted Linux
> :-)
>      Karel
>
>
