Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47885 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751046Ab2LJJGR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 10 Dec 2012 04:06:17 -0500
Date: Mon, 10 Dec 2012 10:06:07 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] ipcs: add --human readable size conversion option
Message-ID: <20121210090607.GB21405@x2.net.home>
References: <1355087316-12422-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1355087316-12422-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 09, 2012 at 09:08:34PM +0000, Sami Kerola wrote:
> +.B \-\-human
> +Show print sizes in human readable format (e.g., 1K 234M 2G).

 Nice idea, but what about create any smart function to print the
 stuff to avoid all the "if (unit == UNIT_DEFAULT) else" in the code?

> +		if (unit == UNIT_DEFAULT)
> +			printf(_("max seg size (kbytes) = %ju\n"),
> +			       lim.shmmax / 1024);
> +		else if (unit == UNIT_HUMAN)
> +			printf(_("max seg size = %s\n"),
> +			       size_to_human_string(SIZE_SUFFIX_1LETTER,
> +						    lim.shmmax));

 ipc_print(IPC_UNIT_KB, _("max seg size), lim.shmmax, "\n");

(append " (bytes) = " if there is not "=" at the end of the string)

> @@ -560,8 +632,17 @@ void print_msg(int msgid)
>  	       msgdata->msg_perm.uid, msgdata->msg_perm.uid,
>  	       msgdata->msg_perm.cuid, msgdata->msg_perm.cgid,
>  	       msgdata->msg_perm.mode);
> -	printf(_("cbytes=%jd\tqbytes=%jd\tqnum=%jd\tlspid=%d\tlrpid=%d\n"),
> -	       msgdata->q_cbytes, msgdata->q_qbytes, msgdata->q_qnum,
> +	if (unit == UNIT_DEFAULT)
> +		printf(_("cbytes=%jd\tqbytes=%jd"), msgdata->q_cbytes,
> +		       msgdata->q_qbytes);

  ipc_print(IPC_UNIT_B, "cbytes=", msgdata->q_cbytes, "\t");
  ipc_print(IPC_UNIT_B, "qbytes=", msgdata->q_qbytes, NULL);

 ... or so.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
