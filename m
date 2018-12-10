Return-Path: <SRS0=pu0z=OT=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298CAC04EB8
	for <util-linux@archiver.kernel.org>; Mon, 10 Dec 2018 11:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB35120880
	for <util-linux@archiver.kernel.org>; Mon, 10 Dec 2018 11:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB35120880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbeLJLqj (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:46:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbeLJLqj (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 10 Dec 2018 06:46:39 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C934308213A;
        Mon, 10 Dec 2018 11:46:38 +0000 (UTC)
Received: from ws.net.home (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BEC7E5DD6B;
        Mon, 10 Dec 2018 11:46:37 +0000 (UTC)
Date:   Mon, 10 Dec 2018 12:46:34 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Rick van Rein <rick@openfortress.nl>
Cc:     util-linux@vger.kernel.org
Subject: Re: PATCH: script: Introduced a streaming output command
Message-ID: <20181210114634.ee5jamwllimdmrdc@ws.net.home>
References: <5C090B46.5090200@openfortress.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C090B46.5090200@openfortress.nl>
User-Agent: NeoMutt/20180716-521-8fffcf
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 10 Dec 2018 11:46:38 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Dec 06, 2018 at 12:43:02PM +0100, Rick van Rein wrote:
> Besides output to a file, this patch introduces commands for
> interactive streaming, such as over a network connection.  

Nice idea ;-)

> A default "scriptstream" command may be locally installed with
> all the bells and whistles that make sense locally.
[...]
>  #include <stdio.h>
> @@ -97,12 +100,16 @@ UL_DEBUG_DEFINE_MASKNAMES(script) =
> UL_DEBUG_EMPTY_MASKNAMES;
>  #endif
> 
>  #define DEFAULT_TYPESCRIPT_FILENAME "typescript"
> +#define DEFAULT_TYPESCRIPT_COMMAND  "scriptstream"

Do we really need the default command? ;-) 

I think the example with nc(1) in the man page is good enough. We do
not need hardcode any path/name in the code.

>  struct script_control {
>  	char *shell;		/* shell to be executed */
>  	char *command;		/* command to be executed */
>  	char *fname;		/* output file path */
>  	FILE *typescriptfp;	/* output file pointer */
> +	int stream;		/* output to streaming command */

It would be better to use one bit for this boolean,

  unsigned int
    stream :1

see and of the struct script_control where are already another
options.

[...]

> +static void wait_for_stream_cmd(struct script_control *ctl, int wait)
> +{
> +	int options = wait ? 0 : WNOHANG;
> +	if (ctl->stream && ctl->typescriptfp) {
> +		DBG(MISC, ul_debug("closing stream subcommand"));
> +		fclose (ctl->typescriptfp);
> +		ctl->typescriptfp = NULL;
> +		kill(ctl->streampid, SIGTERM);
> +	}
> +
> +	DBG(MISC, ul_debug("waiting for stream subcommand"));
> +
> +	waitpid(ctl->streampid, &ctl->streamstatus, options);
>  }
> 
>  static void write_output(struct script_control *ctl, char *obuf,
> @@ -483,6 +505,7 @@ static void handle_signal(struct script_control
> *ctl, int fd)
>  		    || info.ssi_code == CLD_KILLED
>  		    || info.ssi_code == CLD_DUMPED) {
>  			wait_for_child(ctl, 0);
> +			wait_for_stream_cmd(ctl, 0);

    if (ctl->stream)
        wait_for_stream_cmd(ctl, 0);

I guess it would be more robust, than call wait_for_stream_cmd()
in all situations.


>  			ctl->poll_timeout = 10;
> 
>  		/* In case of ssi_code is CLD_TRAPPED, CLD_STOPPED, or CLD_CONTINUED */
> @@ -519,6 +542,7 @@ static void handle_signal(struct script_control
> *ctl, int fd)
>  static void do_io(struct script_control *ctl)
>  {
>  	int ret, eof = 0;
> +	int cmdio[2];

It's detail, but stream_pipe[] wold be more readable :-)

>  	time_t tvec = script_time((time_t *)NULL);
>  	enum {
>  		POLLFD_SIGNAL = 0,
> @@ -533,9 +557,33 @@ static void do_io(struct script_control *ctl)
>  	};
> 
> 
> -	if ((ctl->typescriptfp =
> -	     fopen(ctl->fname, ctl->append ? "a" UL_CLOEXECSTR : "w"
> UL_CLOEXECSTR)) == NULL) {
> -
> +	if (ctl->stream) {
> +		if (pipe(cmdio) == -1) {
> +			warn(_("pipe failed"));
> +			fail(ctl);
> +			exit(1);
> +		}
> +		ctl->streampid = fork();
> +		switch (ctl->streampid) {
> +		case -1: /* error */
> +			warn(_("fork failed"));
> +			fail(ctl);
> +			exit(1);
> +		case 0: /* child */
> +			close(cmdio[1]);
> +			dup2(cmdio[0],0);
> +			execvp(ctl->streamcmd[0], ctl->streamcmd);
> +			fprintf(stderr,_("streaming command failed: %s\r\n"),strerror(errno));
> +			exit(1);

    err(1, _("streaming command failed"));

err() seems better than fprintf() + strerror() + exit();

[...]
> +	/* streaming may be ordered with option --stream or with argc > 1 */
> +	if (argc == 0) {
> +		if (ctl.stream) {
> +			ctl.minicmd[0] = DEFAULT_TYPESCRIPT_COMMAND;
> +			ctl.minicmd[1] = NULL;
> +			ctl.streamcmd = &ctl.minicmd[0];
> +		} else {
> +			/* No default implementation to make this pluggable */
> +			ctl.fname = DEFAULT_TYPESCRIPT_FILENAME;
> +			die_if_link(&ctl);
> +		}
> +	} else if (argc == 1) {
> +		if (ctl.stream) {
> +			ctl.minicmd[0] = argv[0];
> +			ctl.minicmd[1] = NULL;
> +			ctl.streamcmd = &ctl.minicmd[0];
> +		} else {
> +			ctl.fname = argv[0];
> +		}
> +	} else {
> +		/* implicit streaming for more than 1 command argument */
> +		ctl.streamcmd = argv;
> +		ctl.stream = 1;
> +		ctl.flush = 1;
>  	}

Frankly, all the command-line semantic seems complicated and a little
bit like over-engineering. It would be nice to keep it simple and
stupid :)

 script
 script <filename>
 script --stream <command> [arg ...]

The first two ways write to "typescript" or to <filename>. The last
writes to <command> [arg ...].

The options --stream should be no_argument (as you already have) and
<command> [arg ...] is all argv[] after argv += optind.

All you need is

struct script_control {
    char **stream_argv;
    ...
};

main() {

    argv += optind; 
                        
    if (argc > 0) {
        if (ctl.stream)
            ctl.stream_argv = &argv[0];
        else
            ctl.fname = argv[0];
    }

    if (ctl.stream && !ctl.stream_argv)
       err(EXIT_FAILURE, _("streaming command not specified"));
}


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
