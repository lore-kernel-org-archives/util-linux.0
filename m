Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f42.google.com ([209.85.218.42]:34503 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756641AbcJMTOK (ORCPT
        <rfc822;util-linux-ng@vger.kernel.org>);
        Thu, 13 Oct 2016 15:14:10 -0400
Received: by mail-oi0-f42.google.com with SMTP id t73so110732762oie.1
        for <util-linux-ng@vger.kernel.org>; Thu, 13 Oct 2016 12:14:09 -0700 (PDT)
Subject: Re: more(1) may attempt to tcsetattr(3) despite lacking controlling
 terminal
To: Jan Schaumann <jschauma@netmeister.org>, util-linux-ng@vger.kernel.org
References: <20161013143932.GA29451@netmeister.org>
From: Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <57FFDCFA.4070407@gmail.com>
Date: Thu, 13 Oct 2016 14:14:02 -0500
MIME-Version: 1.0
In-Reply-To: <20161013143932.GA29451@netmeister.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Jan Schaumann wrote:
> Hello,
>
> Yesterday I reported the following bug to the Debian maintainers of the
> 'util-linux' package.  They suggested I should bring it up here:
>
>
> more(1) may attempt to call tsetattr(3) on stderr even if its process is
> not in a process group with a controlling terminal.  As a result,
> SIGTTOU will be generated, suspending the process.
>
> The following example illustrates the issue:
>
> $ /bin/sh -c "timeout 60 /bin/sh -c \"ls | more\""
>
> This command will now hang until the timeout, since the shell, ls(1) and
> more(1) commands invoked by timeout(1) will be suspended.

It does not hang for me, but then I don't use systemd.  Perhaps systemd 
should be fixed.

   -- Bruce

