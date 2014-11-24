Return-Path: drake@dasyatidae.net
Message-ID: <54731FDE.805@dasyatidae.net>
Date: Mon, 24 Nov 2014 06:09:02 -0600
From: Drake Wilson <drake@dasyatidae.net>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org, 770211@bugs.debian.org
Subject: Re: LUKS partition types, redux
References: <546D0495.2030803@dasyatidae.net> <20141124113733.GC926@x2.net.home>
In-Reply-To: <20141124113733.GC926@x2.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>

Firstly: thank you very much for engaging in a reasonable discussion about this.

Karel Zak wrote:
> On Wed, Nov 19, 2014 at 02:59:01PM -0600, Drake Wilson wrote:
>> Summary: I would like to reopen the suggestion to add LUKS partition type codes
>> for MBR and for GPT to util-linux's fdisk.  In a previous discussion, it was
>> said that since Linux does not interpret partition types, there is no need for
>> this, but concrete data loss has now occurred as a result of a related bug in
>> other software combined with the lack of a user-visible LUKS type in a similar
>> partitioning program, and I believe that warrants re-examination of the situation.
> 
>  But it seems that the problem is what details partitioning tools
>  provide to end-users rather than problem with data within disk
>  labels. I don't see problem to add FS type column to fdisk(s) (it's
>  already linked with libblkid).

I don't quite understand the relation of this paragraph to what I was talking
about.  The case of data loss via partman-lvm wasn't related to what fdisk
would have presented to me, but what the disklabel presented to partman-lvm
as a result of the choices fdisk would have presented.

>  You want to make a connection between partition type and partition
>  format (FS, LUKS, LVM...). This idea is more than 30years old and it
>  has been always fragile and introduced for poorly designed systems
>  (kernels and boot loaders). 

It's not quite that I _want_ to make such a connection, more that I think it
has already been made and the current interop situation is suboptimal; see
below.  I would be quite happy as well with a single "Linux other" type
instead of a LUKS-specific type.

>  The current trend is to use partition type to define for what purpose
>  we want to use the partition (for example "this is /home")
>  independently on partition format. 

I can see some of that, yes.  I've only recently encountered this.  This can
somewhat conflict with the purpose of disk encryption, incidentally, which
tends to want to keep those subdivisions hidden if possible (thus LUKS+LVM
being a common setup).  I'm not opposed to the idea being around; _requiring_
it would conflict with my goals, but I don't see any evidence of that, so
let's put that away.

>  Anyway, I'd like to minimize number of situations when we depend
>  on GPT/MBR partition types at all.

So, my more concrete concern here is not in places where Linux or util-linux
read partition type codes; it is where fdisk or a similar utility writes them,
and some other program entirely reads them.  In the bad case I ran into, the
"some other system" happened to be partman-lvm from Debian, but it could just
as well be something else.

Here's the specific scenario: imagine I'm a Linux sysadmin who is writing a
disklabel for a new disk which will contain a LUKS volume.  (The volume does
not necessarily correspond to any of the "usage" types you mentioned, and I
may not want to expose that information anyway.)  The type code field in MBR
or GPT exists already; I cannot simply remove it, and there is no null value.
What value do I type in for that field?

The likely chain of events, if I'm using fdisk or a similar tool, is that I
look up the list of type codes included in that tool and pick the "closest"
one.  If there is no LUKS type, and no "Linux other" or "other" type in
general, I'm likely to wind up picking one of the existing Linux types.
This risks the disk being plugged into a system that misinterprets the type,
because those other types are _notionally_ meaningful even if the core Linux
kernel and utilities don't care much.

Adding a LUKS type to the table means I can pick that, and if Linux, cryptsetup,
etc. never read it, that's fine---the point is that no _other_ system will read
it as something it wasn't meant to be either.  A "Linux other" or "generic /
unspecified" type would also satisfy this, but more weakly because it wouldn't
be as visible (and I would actually love to have all three, honestly).

So it's a combined interop and UI problem, and is related to the disklabel data
itself.  And my main goal in participating here is to help avoid other users
running into similar problems to what I did if they write disklabels using fdisk,
by reducing the risk of accidentally encouraging the user to trigger aggressive
interpretation by other software, even if that other software should not have
made such assumptions in the first place.

Does that help at all?

   ---> Drake Wilson
