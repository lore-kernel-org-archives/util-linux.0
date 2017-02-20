Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34546 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750977AbdBTWMS (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 20 Feb 2017 17:12:18 -0500
Received: by mail-qk0-f179.google.com with SMTP id s186so107377074qkb.1
        for <util-linux@vger.kernel.org>; Mon, 20 Feb 2017 14:12:17 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20170220121426.5mr6ab6x7pxt5j4b@ws.net.home>
References: <20170213220641.1395-1-kerolasa@iki.fi> <20170220121426.5mr6ab6x7pxt5j4b@ws.net.home>
From: Sami Kerola <kerolasa@iki.fi>
Date: Mon, 20 Feb 2017 22:12:06 +0000
Message-ID: <CAG27Bk2ENHD+1_sX0qVmVnKC2Ss7jDxSyqhNnaj6NKHNnitsYQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] pull: make smatch scan output easy to digest
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 20 February 2017 at 12:14, Karel Zak <kzak@redhat.com> wrote:
> Merged, but except:
>
> On Mon, Feb 13, 2017 at 10:06:34PM +0000, Sami Kerola wrote:
>>   misc: unify function declarations [smatch scan]
>
> I agree that some unification would be nice, but don't like
>
>    static __attribute__((__noreturn__)) __attribute__((__format__(printf, 1, 2)))
>           void log_err(const char *fmt, ...);
>
> it would be better to keep all the attributes after declaration:
>
>    static void log_err(const char *fmt, ...)
>                     __attribute__((__noreturn__))
>                     __attribute__((__format__(printf, 1, 2)));
>
> it means new line for each attribute. IMHO it's more readable and you
> don't have to search for the function name, etc.

Hi Karel,

That's fair enough, and truth is the patch did not fix many warnings so
I am sure we can live with them.

What comes to moving attributes at end of the declaration that does
not please smatch.

lib/exec_shell.c:33:1: error: attributes should be specified before
the declarator in a function definition
 void exec_shell(void)

I tried to look docs if attribute position really has some special meaning,
but could not find anything. Before digging deeper with this perhaps
someone on the list can tell what is going on with this warning.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
