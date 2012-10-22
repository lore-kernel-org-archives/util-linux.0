Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20121015153924.GL18377@x2.net.home>
References: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
	<20121015153924.GL18377@x2.net.home>
Date: Mon, 22 Oct 2012 21:23:03 +0100
Message-ID: <CAG27Bk1=uZT+CyAG_yULjBXz5tzrVeR16iw2RXQXVEPzggXBfg@mail.gmail.com>
Subject: Re: [PATCH 00/13] make ipcs to use proc
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>, Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

Hi Mike, Karel, and others.

Here comes ipcs & /proc try II.  Some of the proposed change got to be
done, others not.  Detailed comments are after the pull request.

The following changes since commit
0b3e1d9baef8dd7ed121c68a1a480d903fb0ad06:

  fdisk: gpt: use swap_efi_guid for new partitions (2012-10-18 12:16:06
+0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git ipcs

for you to fetch changes up to 528f67d3b5eb23445a2e8dfe4476dfd1b2eda75b:

  docs: update TODO (2012-10-22 20:43:03 +0100)

----------------------------------------------------------------
Sami Kerola (14):
      ipcs: add data structures to read state from /proc & /sys
      ipcs: add /proc and /sys path definitions
      lib/path: add path_getnum_zu() function
      ipcs: determine ipc limits from /proc
      ipcs: add new permissions printing function
      ipcs: read shared memory values from /proc
      ipcs: read message queue values from /proc
      ipsc: read semaphore values from /proc
      ipcs: clean up permissions printing
      ipcs: make individual shared memory id printing to use /proc
      ipcs: make individual message queue id printing to use /proc
      ipcs: make individual semaphore id printing to use /proc
      ipcs: validate numeric user input
      docs: update TODO

 Documentation/TODO      |   4 -
 configure.ac            |   1 +
 include/path.h          |   3 +
 include/pathnames.h     |  11 +
 lib/path.c              |  21 ++
 sys-utils/Makemodule.am |   2 +-
 sys-utils/ipcs.c        | 871
 ++++++++++++++++++++++++++++++++++++------------
 7 files changed, 698 insertions(+), 215 deletions(-)


On Mon, Oct 15, 2012 at 3:00 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Sunday 14 October 2012 16:22:15 Sami Kerola wrote:
>> +             fscanf(f, "%d", &(lim->msgmni));
>
> no need for the paren around lim->msgmni.  same thing applies many
> times in this patch.

Unnecessary parentheses are removed from lots of place.

>> +     if ((msgctl(0, IPC_INFO, (struct msqid_ds *)(void *)&msginfo)) < 0)
>
> the paren around msgctl doesn't make sense.  seems like you do this
> multiple times in this patch and none of them make sense.

Also removed.

>> +     lim->msgmni = (int)msginfo.msgmni;
>> +     lim->msgmnb = (int)msginfo.msgmnb;
>
> these casts don't make sense.  they're both ints.

A lot of casts are removed, including non-sense ones you pointed out.

>> +     lim->msgmax = (size_t)msginfo.msgmax;
>
> msgmax is an int, so it seems like blindly casting to size_t isn't a
> good idea.

I think I got all casts removed.


On Mon, Oct 15, 2012 at 3:07 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Sunday 14 October 2012 16:22:17 Sami Kerola wrote:
>> +static int shmctl_info_wrapper(int maxid, int id, struct shm_data
>> **shmds,
>> +                            int use_proc)
>> +{
>> +     char skipheader[1024];
>> +     int i, shmid;
>> +     struct shm_data *shmdsp;
>> +
>> +     struct shmid_ds shmseg;
>> +     struct ipc_perm *ipcp = &shmseg.shm_perm;
>> +
>> +     *shmds = xmalloc(sizeof(struct shm_data));
>> +     shmdsp = *shmds;
>
> could just one line:
>         shmdsp = *shmds = xmalloc(sizeof(struct shm_data));

True, and done that way.

>> +     shmdsp->next = NULL;
>> +     if (use_proc) {
>> +             FILE *f;
>> +             if ((f = fopen(_PATH_PROC_IPCSHM, "r")) == NULL)
>> +                     return -1;
>
> doesn't this leak memory with shmds ?

Ooops.  Yes, it does.  Fixed.

>> +             fgets(skipheader, 1024, f);
>
> why not just fseek() ?  does that not work on the /proc path ?

Maybe searching for first new line suitable alternative.

while (fgetc(f) != '\n')
        /* skip header */ ;

>> +             for (i = 0; !feof(f); i++) {
>> +                     fscanf(f,
>> +                            "%10d %10d  %4o " SIZE_SPEC
>> +                            " %5lu %5lu  %5lu %5u %5u %5u %5u %10lu %10lu %10lu "
>> +                            SIZE_SPEC " " SIZE_SPEC "\n",
>> +                            &(shmdsp->shm_perm.key),
>> +                            &(shmdsp->shm_perm.id),
>> +                            &(shmdsp->shm_perm.mode),
>> +                            &(shmdsp->shm_segsz),
>> +                            &(shmdsp->shm_cprid),
>> +                            &(shmdsp->shm_lprid),
>> +                            &(shmdsp->shm_nattch),
>> +                            &(shmdsp->shm_perm.uid),
>> +                            &(shmdsp->shm_perm.gid),
>> +                            &(shmdsp->shm_perm.cuid),
>> +                            &(shmdsp->shm_perm.cgid),
>> +                            &(shmdsp->shm_atim),
>> +                            &(shmdsp->shm_dtim),
>> +                            &(shmdsp->shm_ctim),
>> +                            &(shmdsp->shm_rss),
>> +                            &(shmdsp->shm_swp)
>> +                         );
>
> shouldn't this check the return of fscanf() ?

Yes, that should.  Fixed.

>> -void do_shm (char format, int use_proc)
>> +static void freeshms(struct shm_data *shmds)
>>  {
>> -     int maxid, shmid, id;
>> -     struct shmid_ds shmseg;
>> +     while (shmds) {
>> +             struct shm_data *next = shmds->next;
>> +             free(shmds);
>> +             shmds = next;
>> +     }
>> +     return;
>> +}
>
> pointless return statement -> delete

Deleted.


On Mon, Oct 15, 2012 at 6:38 PM, Mike Frysinger <vapier@gentoo.org>
wrote:
> On Sunday 14 October 2012 16:22:25 Sami Kerola wrote:
>> - - (!) rewrite ipcs to use /proc/sys/kernel rather than unreliable syscalls
>> -   (there are problems with 32bit userspace on 64bit kernel)
>
> this makes me a bit suspicious since the new code turns around and uses
> size_t to read values.  that says to me that the same problems that
> [allegedly] plague the kernel syscall interface will bite your proc
> reading code.
>
> looking at the most common case (which will directly apply to all the
> others):
>  - 32bit ia32 kernel: sizeof(size_t) == 4
>  - 64bit x86_64 kernel: sizeof(size_t) == 8
>  - 64bit x86_64 userland: sizeof(size_t) == 8
>  - 32bit ia32 userland: sizeof(size_t) == 4
>  - 32bit x86_x32 userland: sizeof(size_t) == 4
>
> so running any of the last two setups could (in theory) be problematic
> because this new code still uses size_t.

Oh, so that what the rather brief TODO item meant.  I think I need to go
and do my 32/64 bit homework before attempting to fix this.


On Mon, Oct 15, 2012 at 4:39 PM, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Oct 14, 2012 at 09:22:12PM +0100, Sami Kerola wrote:
>> Couple weeks ago I decided to do the ipcs todo item, and today patches
>> got to be ready enough so that I could make final polishing and send
>> them for review.
>
>  What about to use lib/path.c? (you can add things like fscan()
> there..).
>
>  These functions allow to redirect open() requests to some
>  alternative place (for example /proc/foo to /mytests/proc/foo) so you
>  can add --sysroot command line option and write nice regression tests
>  :-) See lscpu for more details.

Good idea.  I made the ipcs to use path.h, and found out it was not
perfectly clean.  Unless someone else is quicker I will someday pull the
cpu related stuff further away from functions meant to be used with proc.

>> As the change is quite large I assume there has to be few bugs.  None
>> of the where intentional, so having multiple people testing is
>> preferable.
>
>  We can create a nice collection of /proc dumps from many archs (see
>  tests/ts/lscpu/mk-input.sh). If you prepare a script for IPC stuff
>  then I can create some dumps in our labs.

The ipcs has annoying tendency to print usernames in nearly all outputs
(other than limits & summary).  If I am not wrong that will make
relocated /proc not have stable output.  But that does not have to be end
of the story.  The ipcs could use tt.c, and many of the problems will
vanish, especially if '-n  numeric uids' option is added.

I have a hunch this is not the last set of patches to ipcs before next
release.

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
