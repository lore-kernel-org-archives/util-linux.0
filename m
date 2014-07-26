Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f181.google.com ([209.85.192.181]:34461 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbaGZPId (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 26 Jul 2014 11:08:33 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so7165872pdj.26
        for <util-linux@vger.kernel.org>; Sat, 26 Jul 2014 08:08:33 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20140724101105.GL26781@x2.net.home>
References: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
	<1406066459-4816-10-git-send-email-kerolasa@iki.fi>
	<20140724101105.GL26781@x2.net.home>
Date: Sat, 26 Jul 2014 16:08:33 +0100
Message-ID: <CAG27Bk3sqpsYLg9ZKkonhRf=_gHMvbYyPQ8ND93_1wQz4TShMQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] logger: add process --id=parent optional argument
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 24 July 2014 11:11, Karel Zak <kzak@redhat.com> wrote:
> On Tue, Jul 22, 2014 at 11:00:58PM +0100, Sami Kerola wrote:
>
>> +     unsigned int    parent:1,
>
>   ppid : 1
>
>> +                     rfc5424_time:1,
>>                       rfc5424_tq:1,
>>                       rfc5424_host:1;
>>  };
>> @@ -281,15 +282,29 @@ static char *xgetlogin()
>>       return cp;
>>  }
>>
>> +static pid_t get_process_id(struct logger_ctl *ctl)
>> +{
>> +     pid_t id = 0;
>> +
>> +     if (ctl->logflags & LOG_PID) {
>> +             if (ctl->parent)
>> +                     id = getppid();
>> +             else
>> +                     id = getpid();
>
>   id = ctl->ppid ? getppid() : getpid();
>
>  :-)

Yep, that is happier code.

https://github.com/kerolasa/lelux-utiliteetit/commit/375223774131ea07d1cb26aa3832c082c1add57b#diff-f68064e0e43fa893a5676182f1572882R291

>> -     fputs(_(" -i, --id              log the process ID too\n"), out);
>> +     fputs(_(" -i, --id[=parent]     log the [parent] process ID too\n"), out);
>
>  what about:
>
>               -i, --id[=pid|ppid]   log PID or PPID (default is PID)
>
>
>  I think it's more robust and readable when you can specify also
>  default setting in scripts.

Support to --id=pid is added.

>  And please, don't use "parent" in code and in the man page. It's
>  confusing. It's PID and PPID.
>
>
>  (I personally don't like "process ID" too, "PID" is the term.)

Various 'process ID' and 'parent' notations are changed to pid and/or
ppid strings. See the github link above.

I will shortly send two logger patches that are previously not seen in
mail list so that they can be publicly reviewed. What comes to
possible merge the maillist versions of the changes are obsolete, and
up to date revisions are available from:

  git://github.com/kerolasa/lelux-utiliteetit.git logger

Here are the changes so far.

      logger: ensure program writes everything to syslog file descriptor
      logger: fix indentation issues
      logger: do not rely only getlogin(3) telling who ran the command
      logger: refactor long if clause
      docs: make logger.1 facilities and levels easier to read
      logger: add function pointer to choose how logging is done
      logger: tidy up main() by adding small functions and ctl data
      logger: add rfc5424 support
      docs: add logger protocol notes to manual page
      logger: add process --id=parent optional argument
      logger: make --stderr print remote server messages
      logger: improve readablity of pencode() function

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
