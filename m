Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34083 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750986AbdE2OGc (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 29 May 2017 10:06:32 -0400
Received: by mail-qk0-f195.google.com with SMTP id u75so8743638qka.1
        for <util-linux@vger.kernel.org>; Mon, 29 May 2017 07:06:32 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20170529100913.er6mwukht5pq4ixc@ws.net.home>
References: <20170527182409.13985-1-kerolasa@iki.fi> <20170527182409.13985-4-kerolasa@iki.fi>
 <20170529100913.er6mwukht5pq4ixc@ws.net.home>
From: Sami Kerola <kerolasa@iki.fi>
Date: Mon, 29 May 2017 15:06:31 +0100
Message-ID: <CAG27Bk1SKKz8xhp-HTH8yn=UqXEVkY7+1=n-8tN7PknzxoDXqw@mail.gmail.com>
Subject: Re: [PATCH 4/4] lib/sysfs: fix format overflow
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 29 May 2017 at 11:09, Karel Zak <kzak@redhat.com> wrote:
> On Sat, May 27, 2017 at 07:24:09PM +0100, Sami Kerola wrote:
>> lib/sysfs.c:343:31: warning: '/start' directive output may be truncated
>> writing 6 bytes into a region of size between 1 and 256
>> [-Wformat-truncation=]
>>
>> lib/sysfs.c:372:32: warning: '/partition' directive output may be truncated
>> writing 10 bytes into a region of size between 1 and 256
>> [-Wformat-truncation=]
>>
>> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
>> ---
>>  lib/sysfs.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/sysfs.c b/lib/sysfs.c
>> index cc290faac..6272b80b4 100644
>> --- a/lib/sysfs.c
>> +++ b/lib/sysfs.c
>> @@ -307,7 +307,7 @@ static struct dirent *xreaddir(DIR *dp)
>>
>>  int sysfs_is_partition_dirent(DIR *dir, struct dirent *d, const char *parent_name)
>>  {
>> -     char path[256];
>> +     char path[strlen(d->d_name) + sizeof("/start") + 1];
>>
>>  #ifdef _DIRENT_HAVE_D_TYPE
>>       if (d->d_type != DT_DIR &&
>> @@ -356,7 +356,6 @@ dev_t sysfs_partno_to_devno(struct sysfs_cxt *cxt, int partno)
>>  {
>>       DIR *dir;
>>       struct dirent *d;
>> -     char path[256];
>>       dev_t devno = 0;
>>
>>       dir = sysfs_opendir(cxt, NULL);
>> @@ -365,6 +364,7 @@ dev_t sysfs_partno_to_devno(struct sysfs_cxt *cxt, int partno)
>>
>>       while ((d = xreaddir(dir))) {
>>               int n, maj, min;
>> +             char path[strlen(d->d_name) + sizeof("/partition") + 1];
>
> why strlen() here? Maybe we can add to c.h macro
>
>  #define ul_dname_sizeof(x)
>     (sizeof(((struct dirent *)0)->d_dname) + sizeof(x) + 1)
>
> or use PATH_MAX ...

For some reason I thought d_name would be allocated, in which case
strlen() would be
more appropriate. Thank you for pointing out it is very static 255
buffer, so added the
proposed ul_dname_sizeof() to c.h and changed the rest of the commits
accordingly.

https://github.com/kerolasa/lelux-utiliteetit/commit/5eb0ea80b376e295aca649acc8f8e2eaa91f30bb

Updates to changes are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git rc2-fixes

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
