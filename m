Return-Path: ludwig.nussel@suse.de
Subject: Re: agetty /etc/issue handling
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <2fb8c760-3be8-a77f-0ab1-ad67ebca63cb@suse.de>
 <20180306104110.k4tis2b23eqykqeh@ws.net.home>
From: Ludwig Nussel <ludwig.nussel@suse.de>
Message-ID: <5089360b-0a43-d754-ebd0-2d428af1c1af@suse.de>
Date: Tue, 6 Mar 2018 13:27:30 +0100
MIME-Version: 1.0
In-Reply-To: <20180306104110.k4tis2b23eqykqeh@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Tue, Mar 06, 2018 at 10:40:14AM +0100, Ludwig Nussel wrote:
>> I just noticed that agetty gained support for /etc/issue.d. Very cool!
> 
> Thanks, according this feedback
> https://github.com/karelzak/util-linux/commit/1fc82a1360305f696dc1be6105c9c56a9ea03f52#commitcomment-27947668
> 
> it seems that /etc/issue.d may conflict with already existing
> solutions in OpenSUSE. Is it true?

There is a package called issue-generator
(https://github.com/thkukuk/issue-generator) that generates /etc/issue
based on content from /{usr/lib,run,etc}/issue.d. There is no real
conflict, just some partial overlap in features. IMO issue-generator
would be mostly obsolete as soon as agetty reads those directories
itself.

> I'll probably add --disable-agetty-issued to make it fully backwardly
> compatible.

TBH I don't think that's necessary.

>> Are there any plans to extend the way it reads those files to a systemd
>> style layering ie with read only parts in /usr, potentially generated
>> ones in /run etc?
> 
> Good idea.
> 
>> Especially the read only part would be interesting. That way distros
>> wouldn't need to ship /etc/isse at all and packages would put their
>> extension in /usr. Ie no interference with admin space.
> 
> What is expected semantic (order)?
> 
> Note that agetty requires the /etc/issue file, the directory is an
> extension to the file. The file may be empty or symlink. This is
> because "rm /etc/issue" is a way how some admins disable agetty output
> at all.

Alternative semantics would be to only use issue.d if /etc/issue
does NOT exist. That would assume that if /etc/issue exists, the
admin created it and doesn't want anything else to be displayed. To
display nothing the file could be created with zero size by the
admin.
Packages would then ship their static issue snippets in /usr and
generate dynamic ones in /run.
The admin would then have the option to either
* create custom content in /etc/issue.d that would be interwoven
   with what packages provide - or
* create /etc/issue to only have that one displayed

Distributions would then have to stop shipping /etc/issue in order
to allow the modular approach to take effect.

> with layering:
> 
>   - verify /etc/issue (access F_OK -- required)
>   - read /etc/issue.d/*.issue
>   - read /run/agetty/issue.d/*.issue
>   - read /usr/lib/agetty/issue.d/*.issue

Is issue.d considered agetty specific or are other gettys expected
to follow suit? If the latter I'd omit the agetty subdirectory.
Alternatively for consistency you'd need to use /etc/agetty/issue.d
I guess :-)
The ordering of layer is right. In systemd semantics files take preference
in order, ie if the same file name exists in /etc and /usr, only the one
in /etc would be displayed.

> use-case:
>      - /etc = system specific files

... created by the admin.

>      - /run = generated files
>      - /usr = installed 3rd party files

Not just third party, that is where packages put static files, ie the
distribution. So I'd move what we currently have in /etc/issue to e.g.
/usr/lib(/agetty)/issue.d/10-opensuse.issue

cu
Ludwig

-- 
  (o_   Ludwig Nussel
  //\
  V_/_  http://www.suse.com/
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard,
Graham Norton, HRB 21284 (AG Nürnberg)
