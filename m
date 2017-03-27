Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751743AbdC0AmD (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 26 Mar 2017 20:42:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 354D9804E2
        for <util-linux@vger.kernel.org>; Mon, 27 Mar 2017 00:41:55 +0000 (UTC)
Date: Mon, 27 Mar 2017 09:41:52 +0900 (JST)
Message-Id: <20170327.094152.1904964943153919266.yamato@redhat.com>
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/4] fincore command
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <20170323144523.24u45orqhq75oosj@ws.net.home>
References: <20170307023352.7340-1-yamato@redhat.com>
        <20170323115825.paxktr7xxgevrcju@ws.net.home>
        <20170323144523.24u45orqhq75oosj@ws.net.home>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Thank you for merging.
The output looks sophisticated.

About RES and RSS, I don't know which is better.
As you know top command users RES and ps command uses RSS...

Masatake YAMATO

> On Thu, Mar 23, 2017 at 12:58:25PM +0100, Karel Zak wrote:
>> On Tue, Mar 07, 2017 at 11:33:48AM +0900, Masatake YAMATO wrote:
>> >  bash-completion/Makemodule.am |   3 +
>> >  bash-completion/fincore       |  25 +++++
>> >  configure.ac                  |   4 +
>> >  misc-utils/Makemodule.am      |   6 ++
>> >  misc-utils/fincore.1          |  76 ++++++++++++++
>> >  misc-utils/fincore.c          | 209 +++++++++++++++++++++++++++++++++++++
>> >  misc-utils/fincore_orig.c     | 235 ++++++++++++++++++++++++++++++++++++++++++
>> >  tests/commands.sh             |   1 +
>> >  tests/expected/fincore/count  |  62 +++++++++++
>> >  tests/ts/fincore/count        | 194 ++++++++++++++++++++++++++++++++++
>> >  10 files changed, 815 insertions(+)
>> >  create mode 100644 bash-completion/fincore
>> >  create mode 100644 misc-utils/fincore.1
>> >  create mode 100644 misc-utils/fincore.c
>> >  create mode 100644 misc-utils/fincore_orig.c
>> >  create mode 100644 tests/expected/fincore/count
>> >  create mode 100755 tests/ts/fincore/count
>> 
>>  Merged (except fincore_orig.c).
>> 
>>  I'll very probably a little bit play with the output :-) It's like to
>>  have human readable sizes (10M) by default, align the numbers to the
>>  right (maybe use libsmartcols if more files specified).
> 
> Implemented, changes:
> 
>  * errors are printed to stderr only, the output is not affected by errors
>  * use libsmartcols
>  * numbers aligned to the right
>  * add --bytes --raw --noheadings --json and --output <list>
>  * you can use $(fincore -o PAGES -nr /etc/passwd) to get only the number
> 
> The default output is:
> 
> $ fincore ~/Mail/Maildir/.notmuch/xapian/*
> PAGES  SIZE FILE
>     0    0B /home/kzak/Mail/Maildir/.notmuch/xapian/flintlock
>     1   28B /home/kzak/Mail/Maildir/.notmuch/xapian/iamchert
>    17 67.4K /home/kzak/Mail/Maildir/.notmuch/xapian/position.baseA
>    17 67.4K /home/kzak/Mail/Maildir/.notmuch/xapian/position.baseB
>  1185  4.2G /home/kzak/Mail/Maildir/.notmuch/xapian/position.DB
>     9 35.7K /home/kzak/Mail/Maildir/.notmuch/xapian/postlist.baseA
>     9 35.7K /home/kzak/Mail/Maildir/.notmuch/xapian/postlist.baseB
> 87831  2.2G /home/kzak/Mail/Maildir/.notmuch/xapian/postlist.DB
>     1  208B /home/kzak/Mail/Maildir/.notmuch/xapian/record.baseA
>     1  208B /home/kzak/Mail/Maildir/.notmuch/xapian/record.baseB
>    66 11.5M /home/kzak/Mail/Maildir/.notmuch/xapian/record.DB
>     7 27.6K /home/kzak/Mail/Maildir/.notmuch/xapian/termlist.baseA
>     7 27.6K /home/kzak/Mail/Maildir/.notmuch/xapian/termlist.baseB
>  1941  1.7G /home/kzak/Mail/Maildir/.notmuch/xapian/termlist.DB
> 
> 
> I'd like to have also PAGES-IN-BYTES column to make it easy for
> humans, but not sure how to call the column... "RES" or "RSS"? 
> 
> For example "343M" rather than "87831" (see above).
> 
> Nice util, thanks!
> 
>     Karel
> 
> -- 
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
