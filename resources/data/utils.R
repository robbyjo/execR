# ExecR
# Version: 0.1
# By: Roby Joehanes
#
# Copyright 2016-2017 Roby Joehanes
# This file is distributed under the GNU General Public License version 3.0.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, version 3 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# args holds the raw options passed into this program and will be NOT deleted once known options have been parsed.
# This will allow custom programs to pass parameters through the command line.

# Utility functions
trim <- function (x) unlist(lapply(as.list(x), function(v) gsub("^\\s+|\\s+$", "", v)));
isDefined <- function(object) exists(as.character(substitute(object)));
isWholeNumber <- function(x, tol = .Machine$double.eps^0.5) abs(x - round(x)) < tol;
paramToList <- function(param_str) {
	ll <- eval(parse(text = paste("list(", param_str, ")")));
	return(ll);
}
processBooleanArg <- function(b, var_name, default=FALSE) {
	if (is.na(b)) return (default);
	if (!is.logical(b)) {
		if (is.numeric(b)) {
			return (b != 0);
		} else if (is.character(b)) {
			b <- toupper(b);
			if (b == "TRUE" | b == "T") {
				return (TRUE);
			} else if (b == "FALSE" | b == "F") {
				return(FALSE);
			}
			if (tolower(gsub("^-*", "", b)) == tolower(var_name)) return(TRUE);
		}
	}
	cat(paste("Unknown characters in ", var_name, "!", sep=""), "\n");
	return (default);
}
processIntegerArg <- function(v, var_name, default=NA) {
	if (is.numeric(v)) {
		if (isWholeNumber(v)) return (v);
		return (default);
	}
	if (is.na(v)) return(default);
	# Attempt to intelligently convert to numeric
	v <- as.numeric(as.character(v));
	if (!is.na(v)) return(v);
	cat(paste("Unknown characters in ", var_name, "!", sep=""), "\n");
	return (default);
}

processFloatArg <- function(v, var_name, default=NA) {
	if (is.numeric(v) | is.na(v)) return(v);
	# Attempt to intelligently convert to numeric
	v <- as.numeric(as.character(v));
	if (!is.na(v)) return(v);
	cat(paste("Unknown characters in ", var_name, "!", sep=""), "\n");
	return (default);
}

# Very simple command line argument parsing
processArgs <- function(args, show=TRUE) {
	stopifnot (length(args) > 0);
	args <- do.call(rbind, regmatches(args, regexpr("=", args), invert = TRUE)); # split by the first equal sign only
	stopifnot (NCOL(args) == 2);
	cat("This program is called with the following parameters:\n");
	colnames(args) <- c("Parameter", "Value");
	args[, 1] <- gsub("^-*", "", args[, 1]); # If option is prefixed by dashes, remove the dashes
	if (show) {
		x <- data.frame(args);
		ff <- x[x[, 1] == "formula", 2];
		x <- x[x[, 1] != "formula", ];
		print(data.frame(x), row.names=FALSE);
		cat(paste("formula =", ff), "\n");
		rm(x, ff);
	}
	rownames(args) <- args[, 1];
	args <- args[, 2];
	return (args);
}
