Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58058 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756037Ab2DDLJU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 4 Apr 2012 07:09:20 -0400
Date: Wed, 4 Apr 2012 13:09:17 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [pull] check stream status
Message-ID: <20120404110917.GN1084@x2.net.home>
References: <CAG27Bk2cNH-x6D=H4C6+NiHJDp4-_dWuU9BJuubTWFOcr-Bu9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk2cNH-x6D=H4C6+NiHJDp4-_dWuU9BJuubTWFOcr-Bu9Q@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 29, 2012 at 10:28:59PM +0200, Sami Kerola wrote:
> Reference: http://www.irill.org/events/ghm-gnu-hackers-meeting/videos/jim-meyering-goodbye-world-the-perils-of-relying-on-output-streams-in-c

 thanks :-)

>  include/fileutils.h |    2 ++
>  lib/fileutils.c     |   37 ++++++++++++++++++++++++++++++++++++-

 I don't like the idea that we need to modify all Makefiles and always
 compile fileutils.c.

 It would be better to add close_{stream,stdout} functions to a
 separate include/closestream.h file as static inline functions.

> +int close_stream(FILE * stream)
> +{
> +	const int some_pending = (__fpending(stream) != 0);
> +	const int prev_fail = (ferror(stream) != 0);
> +	const int fclose_fail = (fclose(stream) != 0);
> +	if (prev_fail || (fclose_fail && (some_pending || errno != EBADF))) {
> +		if (!fclose_fail)
> +			errno = 0;
> +		return EOF;
> +	}
> +	return 0;
> +}
> +
> +/* Use atexit(); */
> +void close_stdout(void)
> +{
> +	if (close_stream(stdout) != 0 && !(errno == EPIPE)) {
> +		char const *write_error = _("write error");
> +		error(0, errno, "%s", write_error);

 Is error() really portable? We already have alternatives for err.h
 stuff, maybe it would be better to use:

 if (errno)
    warn(_("write error"));
 else
    warnx(_("write error"));

 or add alternative for error() to c.h.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
