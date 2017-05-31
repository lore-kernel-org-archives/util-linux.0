Return-Path: util-linux-owner@vger.kernel.org
Received: from [195.159.176.226] ([195.159.176.226]:47919 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbdEaT2Q (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 31 May 2017 15:28:16 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcuu-util-linux-ng@m.gmane.org>)
        id 1dG9Ht-0007bB-2q
        for util-linux@vger.kernel.org; Wed, 31 May 2017 21:28:09 +0200
To: util-linux@vger.kernel.org
From: yumkam@gmail.com (Yuriy M. Kaminskiy)
Subject: Re: [PATCH 4/4] lib/sysfs: fix format overflow
Date: Wed, 31 May 2017 22:28:08 +0300
Message-ID: <m3r2z4eshj.fsf@gmail.com>
References: <20170527182409.13985-1-kerolasa@iki.fi>
        <20170527182409.13985-4-kerolasa@iki.fi>
        <20170529100913.er6mwukht5pq4ixc@ws.net.home>
        <CAG27Bk1SKKz8xhp-HTH8yn=UqXEVkY7+1=n-8tN7PknzxoDXqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Sami Kerola <kerolasa@iki.fi> writes:

> On 29 May 2017 at 11:09, Karel Zak <kzak@redhat.com> wrote:
>> On Sat, May 27, 2017 at 07:24:09PM +0100, Sami Kerola wrote:
>>> lib/sysfs.c:343:31: warning: '/start' directive output may be truncated
>>> writing 6 bytes into a region of size between 1 and 256
>>> [-Wformat-truncation=]
>>>
>>> lib/sysfs.c:372:32: warning: '/partition' directive output may be truncated
>>> writing 10 bytes into a region of size between 1 and 256
>>> [-Wformat-truncation=]
>>>
>>> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
>>> ---
>>>  lib/sysfs.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/lib/sysfs.c b/lib/sysfs.c
>>> index cc290faac..6272b80b4 100644
>>> --- a/lib/sysfs.c
>>> +++ b/lib/sysfs.c
>>> @@ -307,7 +307,7 @@ static struct dirent *xreaddir(DIR *dp)
>>>
>>>  int sysfs_is_partition_dirent(DIR *dir, struct dirent *d, const char *parent_name)
>>>  {
>>> -     char path[256];
>>> +     char path[strlen(d->d_name) + sizeof("/start") + 1];
>>>
>>>  #ifdef _DIRENT_HAVE_D_TYPE
>>>       if (d->d_type != DT_DIR &&
>>> @@ -356,7 +356,6 @@ dev_t sysfs_partno_to_devno(struct sysfs_cxt *cxt, int partno)
>>>  {
>>>       DIR *dir;
>>>       struct dirent *d;
>>> -     char path[256];
>>>       dev_t devno = 0;
>>>
>>>       dir = sysfs_opendir(cxt, NULL);
>>> @@ -365,6 +364,7 @@ dev_t sysfs_partno_to_devno(struct sysfs_cxt *cxt, int partno)
>>>
>>>       while ((d = xreaddir(dir))) {
>>>               int n, maj, min;
>>> +             char path[strlen(d->d_name) + sizeof("/partition") + 1];
>>
>> why strlen() here? Maybe we can add to c.h macro
>>
>>  #define ul_dname_sizeof(x)
>>     (sizeof(((struct dirent *)0)->d_dname) + sizeof(x) + 1)
>>
>> or use PATH_MAX ...
>
> For some reason I thought d_name would be allocated, in which case
> strlen() would be
> more appropriate. Thank you for pointing out it is very static 255
> buffer, so added the

Is this *defined by standard*? I believe not.
=== man dirent.h ===
       The character array d_name is of unspecified size, but  the  number  of
       bytes preceding the terminating null byte shall not exceed {NAME_MAX}.
=== cut ===
Same apply to [patch 3/4].

(Of course, both loopdev and sysfs are linux-specific, so
portablity is not very important (however, it is not that unheard of
from glibc or gcc folks to suddenly change those standard-unspecified
things, and then say "don't rely on undefined behavior, baka >_<"; then
again, there are uclibc, dietlibc, klibc, etc)).

> proposed ul_dname_sizeof() to c.h and changed the rest of the commits
> accordingly.
>
> https://github.com/kerolasa/lelux-utiliteetit/commit/5eb0ea80b376e295aca649acc8f8e2eaa91f30bb
>
> Updates to changes are available in the git repository at:
>   git://github.com/kerolasa/lelux-utiliteetit.git rc2-fixes

