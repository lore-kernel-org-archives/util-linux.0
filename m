Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33689 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753878AbbGTJcI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 20 Jul 2015 05:32:08 -0400
Date: Mon, 20 Jul 2015 11:32:06 +0200
From: Karel Zak <kzak@redhat.com>
To: Alex Bligh <alex@alex.org.uk>
Cc: util-linux@vger.kernel.org, Ruediger Meier <ruediger.meier@ga-group.nl>
Subject: Re: [PATCH] Add support to logger for RFC6587 octet counting
Message-ID: <20150720093206.GG11633@ws.net.home>
References: <1436983308-14944-1-git-send-email-alex@alex.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436983308-14944-1-git-send-email-alex@alex.org.uk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 15, 2015 at 07:01:48PM +0100, Alex Bligh wrote:
> This patch adds support to logger for RFC6587 octet counting.
> RFC6587 provides support for two sorts of framing:

 Rudi, any objection? (if I good remember you have also talked about
 framing stuff ;-)

    Karel

> 
> 1. Octet counting (at RFC6587 s3.4.1)
> 
>    In essence each frame is preceded by a decimal length and a
>    space.
> 
> 2. Non-transparent framing (at RFC6587 s3.4.2), also called
>    'octet stuffing'
> 
>    In essence each frame is terminated by a `\n`
> 
> Prior to this patch, logger used option 2 (non-transparent framing)
> on TCP, and used no framing on UDP. After this patch, the default
> behaviour is unchanged, but if the '--octet-count' option is supplied,
> option 1 is used for both TCP and UDP. Arguably octet count framing
> makes little sense on UDP, but some servers provide it and this
> allows testing of those servers.
> 
> Signed-off-by: Alex Bligh <alex@alex.org.uk>
> ---
>  misc-utils/logger.1 |  5 +++++
>  misc-utils/logger.c | 24 +++++++++++++++++-------
>  2 files changed, 22 insertions(+), 7 deletions(-)
> 
> **** Please keep me in the CC for any replies as I am not subscribed
> to this list ****
> 
> diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
> index bb81295..36c923d 100644
> --- a/misc-utils/logger.1
> +++ b/misc-utils/logger.1
> @@ -179,6 +179,11 @@ The RFC 5424 protocol has been the default for
>  .B logger
>  since version 2.26.
>  .TP
> +.B \-\-octet\-count
> +Use the RFC 6587 octet counting framing method for sending messages. When
> +this option is not used, the default is no framing on UDP, and RFC6587
> +non-transparent-framing (also known as octet stuffing) on TCP.
> +.TP
>  .BR \-s , " \-\-stderr"
>  Output the message to standard error as well as to the system log.
>  .TP
> diff --git a/misc-utils/logger.c b/misc-utils/logger.c
> index 8908dfc..c5cba69 100644
> --- a/misc-utils/logger.c
> +++ b/misc-utils/logger.c
> @@ -92,7 +92,8 @@ enum {
>  	OPT_SOCKET_ERRORS,
>  	OPT_MSGID,
>  	OPT_NOACT,
> -	OPT_ID
> +	OPT_ID,
> +	OPT_OCTET_COUNT
>  };
>  
>  struct logger_ctl {
> @@ -116,7 +117,8 @@ struct logger_ctl {
>  			rfc5424_time:1,		/* include time stamp */
>  			rfc5424_tq:1,		/* include time quality markup */
>  			rfc5424_host:1,		/* include hostname */
> -			skip_empty_lines:1; /* do not send empty lines when processing files */
> +			skip_empty_lines:1,	/* do not send empty lines when processing files */
> +			octet_count:1;		/* use RFC6587 octet counting */
>  };
>  
>  /*
> @@ -372,19 +374,22 @@ static const char *rfc3164_current_time(void)
>  }
>  
>  /* writes generated buffer to desired destination. For TCP syslog,
> - * we use RFC6587 octet-stuffing. This is not great, but doing
> - * full blown RFC5425 (TLS) looks like it is too much for the
> - * logger utility.
> + * we use RFC6587 octet-stuffing (unless octet-counting is selected).
> + * This is not great, but doing full blown RFC5425 (TLS) looks like
> + * it is too much for the logger utility. If octet-counting is
> + * selected, we use that.
>   */
>  static void write_output(const struct logger_ctl *ctl, const char *const msg)
>  {
>  	char *buf;
> -	const size_t len = xasprintf(&buf, "%s%s", ctl->hdr, msg);
> +	const size_t len = ctl->octet_count ?
> +		xasprintf(&buf, "%zu %s%s", strlen(ctl->hdr)+strlen(msg), ctl->hdr, msg):
> +		xasprintf(&buf, "%s%s", ctl->hdr, msg);
>  
>  	if (!ctl->noact) {
>  		if (write_all(ctl->fd, buf, len) < 0)
>  			warn(_("write failed"));
> -		else if (ctl->socket_type == TYPE_TCP) {
> +		else if ((ctl->socket_type == TYPE_TCP) && !ctl->octet_count) {
>  			/* using an additional write seems like the best compromise:
>  			 * - writev() is not yet supported by framework
>  			 * - adding the \n to the buffer in formatters violates layers
> @@ -705,6 +710,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
>  	fputs(_(" -e, --skip-empty         do not log empty lines when processing files\n"), out);
>  	fputs(_("     --no-act             do everything except the write the log\n"), out);
>  	fputs(_(" -p, --priority <prio>    mark given message with this priority\n"), out);
> +	fputs(_("     --octet-count        use rfc6587 octet counting\n"), out);
>  	fputs(_("     --prio-prefix        look for a prefix on every line read from stdin\n"), out);
>  	fputs(_(" -s, --stderr             output message to standard error as well\n"), out);
>  	fputs(_(" -S, --size <size>        maximum size for a single message\n"), out);
> @@ -780,6 +786,7 @@ int main(int argc, char **argv)
>  		{ "port",	   required_argument, 0, 'P'		   },
>  		{ "version",	   no_argument,	      0, 'V'		   },
>  		{ "help",	   no_argument,	      0, 'h'		   },
> +		{ "octet-count",   no_argument,	      0, OPT_OCTET_COUNT   },
>  		{ "prio-prefix",   no_argument,	      0, OPT_PRIO_PREFIX   },
>  		{ "rfc3164",	   no_argument,	      0, OPT_RFC3164	   },
>  		{ "rfc5424",	   optional_argument, 0, OPT_RFC5424	   },
> @@ -854,6 +861,9 @@ int main(int argc, char **argv)
>  			exit(EXIT_SUCCESS);
>  		case 'h':
>  			usage(stdout);
> +		case OPT_OCTET_COUNT:
> +			ctl.octet_count = 1;
> +			break;
>  		case OPT_PRIO_PREFIX:
>  			ctl.prio_prefix = 1;
>  			break;
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
