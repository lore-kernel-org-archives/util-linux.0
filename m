Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20130823100727.GB32136@x2.net.home>
References: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
	<20130823100727.GB32136@x2.net.home>
Date: Fri, 23 Aug 2013 11:42:49 +0100
Message-ID: <CAG27Bk0vS1L=X9u+L9DyOe_LWnMLTMGX1BFqzg2B_ynBMpkMRw@mail.gmail.com>
Subject: Re: [PATCH 00/16] pull: additions recent to last(1) work, plus few
 small changes
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 23 August 2013 11:07, Karel Zak <kzak@redhat.com> wrote:
>>       last: use ISO 8601 time format for --fulltimes
>
>  This is not backwardly compatible. Not applied.
>
>  We need --fulltimes[=ctime|iso] or add --output=<list> and use lib/tt.c to
>  generate output with arbitrary columns and formats.

I thought the --fulltimes has not been released yet. The backwards
compatibility sounds good reason to do --output=<list>. I'll start
working with that ~next week.

Thank you for reviews & merges.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
