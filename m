Return-Path: urban@unix-beratung.de
Subject: Re: Feature request: write out buffer to typescript on SIGTERM
To: Karel Zak <kzak@redhat.com>
References: <55B6B370.5020602@unix-beratung.de>
 <20150728083932.GG6865@ws.net.home>
Cc: util-linux@vger.kernel.org
From: Robert Urban <urban@unix-beratung.de>
Message-ID: <55B7DA01.6080204@unix-beratung.de>
Date: Tue, 28 Jul 2015 21:37:37 +0200
MIME-Version: 1.0
In-Reply-To: <20150728083932.GG6865@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>

Um, I cloned git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git
yesterday, built it, and tested it. If I send it SIGTERM, it prints "Terminated"
and disappears. The typescript file is empty.

Or do you mean something else?

Rob

On 07/28/2015 10:39 AM, Karel Zak wrote:
> On Tue, Jul 28, 2015 at 12:40:48AM +0200, Robert Urban wrote:
>> is there a good reason why script does not flush it's typescript buffer when it
>> gets a signal such as SIGTERM?
> Not sure if you're talking about the current script(1) in git tree
> (it's a new version) or about the original version.
>
> I have improved sensitivity to the SIG{TERM,INT,QUIT}, now it properly
> terminates the session and close the files. Previously it called
> abort() (the version in git).
>
>     Karel
>
>
